require 'nokogiri'
require 'open-uri'

require_relative '../lib/result.rb'

class Search
  attr_reader :topic
  attr_reader :html_doc

  WEB_SITE = "https://stackoverflow.com/search?q=".freeze

  def initialize(topic)
    @topic = topic   
    Load_HTML() 
  end

  def url_for_scraping
    WEB_SITE + URI::encode(@topic)
  end

  def Load_HTML
    begin
      @html_doc = Nokogiri::HTML(open(url_for_scraping))  
    rescue
      @html_doc = nil
    end  
    @html_doc
  end






  
  private


end
