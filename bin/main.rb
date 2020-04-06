#! /usr/bin/env ruby

def print_result(results_per_page)

  (1..results_per_page).each { |v|
    ra = "\n-------------"
    ra += "\nQ: What is Lorem Ipsum?"
    ra += "\nD: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letra..."
    ra += "\nTags: Lorem, Ipsum, Dummy, Text"
    ra += "\nVotes: 100 | Answers: 100"
    ra += "\nDate: asked Jun 10' 20"
    ra += "\nAuthor: John Doe"
    ra += "\nVisit: https://localhost.xyz"
    ra += "\n-------------"
    puts ra    
  }
end    



system('clear')

puts '--------------------------------'
puts 'Welcome to this Web Scraper'
puts 'You can ask for any topic about programming and it will be searched in stackoverflow.com'
puts '--------------------------------'

puts 'What do you want to search?: '
topic = gets.chomp
while topic.empty?
  puts 'You must type a topic. What do you want to search?: '
  topic = gets.chomp
end

total_results = 5
results_per_page = -1

puts "\nThere are #{total_results} results for '#{topic}'.\n\n"
choose_message = 'How many results per page would you like to show?:'

if total_results <= 2
  results_per_page = total_results
  
elsif total_results > 2 && total_results <= 4
  choose_message += "\n(1): 2 results per page.\n(2): Show all results."  
  puts choose_message

  results_per_page = gets.chomp
  while [1, 2].none?(results_per_page.to_i)
    puts "\nYou must choose an option. #{choose_message}"
    results_per_page = gets.chomp
  end

elsif total_results > 4 && total_results <= 6
  choose_message += "\n(1): 2 results per page.\n(2): 4 results per page\n(3): Show all results."    
  puts choose_message

  results_per_page = gets.chomp
  while [1, 2, 3].none?(results_per_page.to_i)
    puts "\nYou must choose an option. #{choose_message}"
    results_per_page = gets.chomp
  end

else
  puts "\n(1): 2 results per page.\n(2): 4 results per page\n(3): 6 results per page."
  results_per_page = gets.chomp
  unless results_per_page == '1' || results_per_page == '2'
    puts "You must choose an option:\n(1): 2 results per page.\n(2): Show all results."
    results_per_page = gets.chomp
  end
end
#print_result(results_per_page)  



