require 'nokogiri'

class Result

  attr_reader :q_index
  attr_accessor :question
  attr_accessor :detail
  attr_accessor :tags
  attr_accessor :votes
  attr_accessor :answers
  attr_accessor :date
  attr_accessor :author
  attr_accessor :visit_url

  def initialize(q_index)
    @q_index = q_index
    @question = ''
    @detail = ''
    @tags = ''
    @votes = ''
    @answers = ''
    @date = ''
    @author = ''
    @visit_url = ''
  end
end