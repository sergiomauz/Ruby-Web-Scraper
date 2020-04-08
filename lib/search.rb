# rubocop: disable Layout/LineLength

require 'nokogiri'
require 'open-uri'

require_relative '../lib/result.rb'

class Search
  attr_reader :topic
  attr_reader :html_doc
  attr_reader :total_results

  def initialize(topic)
    @topic = topic
    load_html
  end

  def url_for_scraping
    WEB_SITE + URI.encode(@topic)
  end

  private

  WEB_SITE = 'https://stackoverflow.com/search?q='.freeze

  def load_html
    @html_doc = Nokogiri.HTML(URI.open(url_for_scraping))
    @total_results = @html_doc.at_css("div#mainbar div[class='grid--cell fl1 fs-body3 mr12']").content.to_s.delete('results').strip.to_i
  rescue LoadHtmlTypeOfException => e
    @html_doc = nil
    raise e
  end
end

# rubocop: enable Layout/LineLength
