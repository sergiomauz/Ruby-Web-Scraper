# rubocop: disable Layout/LineLength, Metrics/BlockLength

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

  total_results = search.total_results
  results_per_page = '1'
  options_for_results = []

  if total_results.positive?
    puts "\nThere are #{total_results} results for '#{topic}'.\n"
    choose_message = 'How many results per page would you like to show?:'

    if total_results > 15 && total_results <= 30
      choose_message += "\n(1): 15 results per page.\n(2): Show all results."
      options_for_results = %w[1 2]
    elsif total_results > 30
      choose_message += "\n(1): 15 results per page.\n(2): 30 results per page."
      options_for_results = %w[1 2]
    end

    if !options_for_results.empty?
      puts "\n" + choose_message
      results_per_page = gets.chomp
      while options_for_results.none?(results_per_page)
        puts "\nYou must choose an option. #{choose_message}"
        results_per_page = gets.chomp
      end
    else
      results_per_page = '1'
    end

    total_pages = (total_results % (15 * results_per_page.to_i)).zero? ? (total_results / (15 * results_per_page.to_i)) : (total_results / (15 * results_per_page.to_i)).to_i + 1

    puts "\nThere are #{total_pages} page(s). Showing page 1 of #{total_pages}\n"
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
        
        puts search.to_string
      end
    else
      puts search.to_string
    end
  else
    puts "\nThere are no results for '#{topic}'.\n"
  end

  choose_message = 'Would you like to start a new search? (y/n)'
  puts "\n" + choose_message
  start_search = gets.chomp
  while %w[y n].none?(start_search)
    puts "\nYou must choose an option. #{choose_message}"
    start_search = gets.chomp
  end
end

# rubocop: enable Layout/LineLength, Metrics/BlockLength
