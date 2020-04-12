require_relative '../lib/search.rb'

RSpec.describe Search do
  let(:ruby) {'Google Calendar ruby'}
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

end
