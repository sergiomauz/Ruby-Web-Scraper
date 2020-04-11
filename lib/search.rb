# rubocop: disable Layout/LineLength, Metrics/MethodLength, Metrics/AbcSize, Lint/UriEscapeUnescape
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

require 'nokogiri'
require 'open-uri'
require 'fileutils'

require_relative '../lib/result.rb'

class Search
  attr_reader :topic
  attr_reader :html_doc
  attr_reader :total_results
  attr_reader :first_request
  attr_reader :result
  attr_accessor :page_number

  WEB_SITE = 'https://stackoverflow.com'.freeze

  def initialize(topic)
    @topic = topic
    @result = []
    @page_number = 1
    @first_request = true
  end

  def to_prompt
    parse_html

    str = ''
    if @total_results.positive?
      str += "\n-------------\nScraping #{url_for_scraping} . Started at #{Time.now.strftime('%Y-%m-%d %H:%M')}"
      @result.each do |item|
        str += "\n-------------"\
            "\nTITLE-#{item.q_index} | #{item.question}"\
            "\nVISIT: #{item.visit_url}"\
            "\nTAGS: #{item.tags}"\
            "\nVOTES: #{item.votes} | Answers: #{item.answers}"\
            "\nDATE AND AUTHOR: Asked on #{item.date} by #{item.author}"\
            "\nDETAIL: #{item.resume}"
      end
      str += "\n-------------\nScraping #{url_for_scraping} . Finished at #{Time.now.strftime('%Y-%m-%d %H:%M')}"
    elsif @total_results.negative?
      str += "\nThere was an error. The website requested a Human Verification using a Google Captcha through a browser. Try again in one minute."
    end
    str
  end

  def to_file
    str = to_prompt
    begin
      FileUtils.mkdir_p('scrap')
      file = File.open('scrap/results.txt', 'w')
      file.write(str)
    rescue IOError => e
      raise e
    ensure
      file&.close
    end
  end

  def request_info
    @result = []
    begin
      @html_doc = Nokogiri.HTML(URI.open(url_for_scraping))
      if @first_request
        parse_html
        @first_request = false
      end
    rescue RequestInfoTypeOfException => e
      @html_doc = nil
      raise e
    end
    @html_doc
  end

  private

  def url_for_scraping
    WEB_SITE + '/search?tab=Relevance&page=' + @page_number.to_s + '&q=' + URI.encode(@topic)
  end

  def parse_html
    if @html_doc.at_css("h1[class='fs-headline1 mb12']").is_a?(NilClass) || @html_doc.at_css("div[class='fs-headline1 mb12']").is_a?(NilClass)
      @total_results = @html_doc.at_css("div#mainbar div[class='grid--cell fl1 fs-body3 mr12']").content.delete('results').strip.to_i
      if @total_results.positive?
        @html_doc.css("div#mainbar div[class='question-summary search-result']").each do |item|
          r = Result.new(item['data-position'])

          r.question = item.at_css("a[class='question-hyperlink']").content.strip
          r.visit_url = WEB_SITE + item.at_css("a[class='question-hyperlink']")['href']
          r.votes = item.at_css("span[class='vote-count-post ']").content.strip
          r.date = item.at_css("span[class='relativetime']").content.strip
          r.author = item.at_css("div[class='started fr'] a").is_a?(NilClass) ? item.at_css("div[class='started fr']").content.strip.sub("answered #{r.date} by ", '') : item.at_css("div[class='started fr'] a").content
          r.resume = item.at_css("div[class='excerpt']").content.strip.gsub(/\s+/, ' ')

          r.answers = '0'
          r.answers = item.at_css("div[class='status answered-accepted'] strong").content + ' [Thread with answer(s) accepted]' unless item.at_css("div[class='status answered-accepted']").is_a?(NilClass)
          r.answers = item.at_css("div[class='status unanswered'] strong").content unless item.at_css("div[class='status unanswered']").is_a?(NilClass)
          r.answers = item.at_css("div[class='status answered'] strong").content unless item.at_css("div[class='status answered']").is_a?(NilClass)

          item.css("a[class='post-tag']").each { |tag| r.tags += ', ' + tag }
          r.tags = r.tags.strip.empty? ? '-No tags-' : r.tags.chomp[1..-1].strip

          @result.push(r)
        end
      end
    else
      @total_results = -1
    end
  rescue ParseHtmlTypeOfException => e
    raise e
  end
end

# rubocop: enable Layout/LineLength, Metrics/MethodLength, Metrics/AbcSize, Lint/UriEscapeUnescape
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
