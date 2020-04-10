# rubocop: disable Metrics/BlockLength

require_relative '../lib/result.rb'
require_relative '../lib/search.rb'
require_relative '../bin/main_options.rb'

system('clear')
puts '--------------------------------'
puts 'Welcome to this Web Scraper'
puts 'You can ask for any topic about programming and it will be searched in stackoverflow.com'
puts '--------------------------------'

start_search = Options.for_start_search
loop do
  break unless start_search == 'y'

  topic = Options.for_topic
  search = Search.new(topic)
  search.request_info

  if search.total_results.positive?

    # 15 results per page is the standard for a search in stackoverflow
    total_pages = (search.total_results % 15).zero? ? (search.total_results / 15) : (search.total_results / 15).to_i + 1

    # stackoverflow has a limit of 33 pages
    total_pages = 33 if total_pages > 33

    puts "\nThere are #{search.total_results} results for '#{search.topic}'. Available #{total_pages} page(s) .\n"
    if total_pages > 1
      options_for_results = (1..total_pages).map(&:to_s).push('e')
      loop do
        page_number = Options.for_page_number(options_for_results, total_pages)
        break if page_number == 'e'

        search.page_number = page_number.to_i
        search.request_info
        choose_output = Options.for_choose_output
        if choose_output == '1'
          search.to_file
          puts "\nYour results are in 'scrap/results.txt'"
        else
          puts search.to_prompt
        end
      end
    else
      choose_output = Options.for_choose_output
      if choose_output == '1'
        search.to_file
        puts "\nYour results are in 'scrap/results.txt'"
      else
        puts search.to_prompt
      end
    end
  else
    puts "\nThere are no results for '#{search.topic}'.\n"
  end

  start_search = Options.for_start_search
end

# rubocop: enable Metrics/BlockLength
