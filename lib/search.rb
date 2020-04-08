# rubocop: disable Layout/LineLength

require 'nokogiri'
require 'open-uri'

require_relative '../lib/result.rb'

class Search
  attr_reader :topic
  attr_reader :html_doc
  attr_reader :total_results

  attr_reader :result

  def initialize(topic)
    @topic = topic
    @result = []
    load_html
  end

  def url_for_scraping
    WEB_SITE + URI.encode_www_form_component(@topic)
  end

  private

  WEB_SITE = 'https://stackoverflow.com/search?q='.freeze

  def load_html
    @html_doc = Nokogiri.HTML(URI.open(url_for_scraping))
    @total_results = @html_doc.at_css("div#mainbar div[class='grid--cell fl1 fs-body3 mr12']").content.to_s.delete('results').strip.to_i
    @html_doc.css("div#mainbar div[class='question-summary search-result']").each do |item|
      r = Result.new
      r.question = item.at_css("a[class='question-hyperlink']").content.to_s.lstrip.chop[3..-1]
      @result.push(r)
    end

  rescue LoadHtmlTypeOfException => e
    @html_doc = nil
    raise e
  end
end

# rubocop: enable Layout/LineLength
