# rubocop: disable Layout/LeadingCommentSpace, Layout/LineLength

require_relative '../lib/search.rb'

RSpec.describe Search do
  let(:ruby) { 'Google Calendar ruby' }
  let(:search) { Search.new(ruby) }

  describe '#initialize' do
    it '-first_request- attribute is TRUE when Search object is created' do
      expect(search.first_request).to eql(true)
    end

    it '-page_number- attribute is 1 when Search object is created' do
      expect(search.page_number).to eql(1)
    end

    it '-result- attribute is EMPTY when Search object is created' do
      expect(search.result).to eql([])
    end

    it '-topic- attribute is THE SAME than the parameter when Search object is created' do
      expect(search.topic).to eql(ruby)
    end
  end

  describe '#after_request_info' do
    it '-html_doc- attribute is NOT NIL after execute -request_info-' do
      expect(search.request_info).to be_instance_of(Nokogiri::HTML::Document)
    end
  end

  describe '#to_prompt_first_request' do
    it 'Returns a string that contains substrings such as TITLE, VISIT, TAGS, VOTES, DATE AND AUTHOR' do
      #Wait 5 seconds before to request. It avoids a message requesting a Captcha
      sleep(5)
      search.request_info

      if search.total_results.positive?
        expect(search.to_prompt).to include 'TITLE', 'VISIT', 'TAGS', 'VOTES', 'DATE AND AUTHOR', 'DETAIL'
      elsif search.total_results.negative?
        expect(search.to_prompt).to include 'There was an error. The website requested a Human Verification using a Google Captcha through a browser. Try again in one minute.'
      else
        expect(search.to_prompt).to eql('')
      end
    end
  end

  describe '#to_prompt_second_request' do
    it 'Returns a string that contains substrings such as TITLE, VISIT, TAGS, VOTES, DATE AND AUTHOR' do
      #Wait 5 seconds before to request. It avoids a message requesting a Captcha
      sleep(5)
      search.request_info

      #Wait 5 seconds before to request. It avoids a message requesting a Captcha
      sleep(5)
      search.request_info

      if search.total_results.positive?
        expect(search.to_prompt).to include 'TITLE', 'VISIT', 'TAGS', 'VOTES', 'DATE AND AUTHOR', 'DETAIL'
      elsif search.total_results.negative?
        expect(search.to_prompt).to include 'There was an error. The website requested a Human Verification using a Google Captcha through a browser. Try again in one minute.'
      else
        expect(search.to_prompt).to eql('')
      end
    end
  end
end

# rubocop: enable Layout/LeadingCommentSpace, Layout/LineLength
