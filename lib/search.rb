# rubocop: disable Layout/LineLength

require 'nokogiri'
require 'open-uri'

require_relative '../lib/result.rb'

class Search
  attr_reader :topic
  attr_reader :html_doc
  attr_reader :total_results
  attr_reader :results_per_page  
  attr_reader :result

  attr_accessor :page_number

  def initialize(topic)
    @topic = topic
    @result = []
    @page_number = 1
    load_html
  end

  def to_string 
    load_html

    ra = ''
    @result.each do |v|
      ra += "\n-------------"\
            "\nQ-#{v.q_index}: #{v.question}"\
            "\nVISIT: #{v.visit_url}"\
            "\nTAGS: #{v.tags}"\
            "\nVOTES: #{v.votes} | Answers: #{v.answers}"\
            "\nDATE: Asked on #{v.date}"\
            "\nAUTHOR: #{v.author}"            
    end
    ra += "\n-------------"
    ra
  end

  private

  WEB_SITE = 'https://stackoverflow.com'.freeze

  def url_for_scraping
    WEB_SITE + '/search?page=' + @page_number.to_s + '&q=' + URI.encode_www_form_component(@topic)
  end

  def load_html
    @html_doc = Nokogiri.HTML(URI.open(url_for_scraping))
    parse_html(@html_doc)
  rescue LoadHtmlTypeOfException => e
    @html_doc = nil
    raise e
  end

  def parse_html(html_doc)
    @total_results = html_doc.at_css("div#mainbar div[class='grid--cell fl1 fs-body3 mr12']").content.to_s.delete('results').strip.to_i
    html_doc.css("div#mainbar div[class='question-summary search-result']").each do |item|      
      r = Result.new(item['data-position'])            

      r.question = item.at_css("a[class='question-hyperlink']").content.to_s.lstrip.chop[3..-1]      
      r.visit_url = WEB_SITE + item.at_css("a[class='question-hyperlink']")['href']            
      r.votes = item.at_css("span[class='vote-count-post ']").content
      r.date = item.at_css("span[class='relativetime']").content
      r.author = item.at_css("div[class='started fr'] a").content      
      if item.at_css("div[class='status answered']").is_a?(NilClass) && item.at_css("div[class='status unanswered']").is_a?(NilClass)
        r.answers = item.at_css("div[class='status answered-accepted'] strong").content      
      elsif item.at_css("div[class='status answered']").is_a?(NilClass) && item.at_css("div[class='status answered-accepted']").is_a?(NilClass)
        r.answers = item.at_css("div[class='status unanswered'] strong").content
      else
        r.answers = item.at_css("div[class='status answered'] strong").content      
      end              
      item.css("a[class='post-tag']").each { |tag|
        r.tags += ', ' + tag
      }
      r.tags = r.tags.lstrip.chop[2..-1]      

      @result.push(r)
    end
  rescue ParseHtmlTypeOfException => e
    raise e
  end
end

# rubocop: enable Layout/LineLength
