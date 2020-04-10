# rubocop: disable Metrics/BlockLength

require_relative '../lib/result.rb'
require_relative '../lib/search.rb'

system('clear')
puts '--------------------------------'
puts 'Welcome to this Web Scraper'
puts 'You can ask for any topic about programming and it will be searched in stackoverflow.com'
puts '--------------------------------'

puts "\nDo you want to start searching? (y/n)"
start_search = gets.chomp
while %w[y n].none?(start_search)
  puts "\nYou must choose a valid option. Do you want to start searching? (y/n)"
  start_search = gets.chomp
end

loop do
  break unless start_search == 'y'

  puts "\nWhat do you want to search?: "
  topic = gets.chomp
  while topic.empty?
    puts 'You must type a topic. What do you want to search?: '
    topic = gets.chomp
  end

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
      choose_message = "Which page do you want to show?\n(Type a number from 1 to #{total_pages} or 'e' for exit): "

      loop do
        puts "\n" + choose_message
        page_number = gets.chomp
        while options_for_results.none?(page_number)
          puts "\nYou must choose an option. #{choose_message}"
          page_number = gets.chomp
        end
        break if page_number == 'e'

        search.page_number = page_number.to_i
        search.request_info

        puts search.to_prompt
      end
    else
      puts search.to_prompt
    end
  else
    puts "\nThere are no results for '#{search.topic}'.\n"
  end

  choose_message = 'Would you like to start a new search? (y/n)'
  puts "\n" + choose_message
  start_search = gets.chomp
  while %w[y n].none?(start_search)
    puts "\nYou must choose an option. #{choose_message}"
    start_search = gets.chomp
  end
end

# rubocop: enable Metrics/BlockLength
