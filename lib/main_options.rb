class Options
  def self.for_page_number(options_for_results, total_pages)
    message_for_choose = "Which page do you want to show?\n(Type a number from 1 to #{total_pages} or 'e' for exit): "
    puts "\n" + message_for_choose
    page_number = gets.chomp
    while options_for_results.none?(page_number)
      puts "\nYou must choose an option. #{message_for_choose}"
      page_number = gets.chomp
    end
    page_number
  end

  def self.for_choose_output
    message_for_choose = "Do you want to:\n1. Get a file.\n2. Prompt in your screen."
    puts "\n" + message_for_choose
    choose_output = gets.chomp
    while %w[1 2].none?(choose_output)
      puts "\nYou must choose an option. #{message_for_choose}"
      choose_output = gets.chomp
    end
    choose_output
  end

  def self.for_topic
    message_for_choose = 'What do you want to search?: '
    puts "\n" + message_for_choose
    topic = gets.chomp
    while topic.empty?
      puts "\nYou must type a topic. #{message_for_choose}"
      topic = gets.chomp
    end
    topic
  end

  def self.for_start_search
    message_for_choose = 'Would you like to start a new search? (y/n)'
    puts "\n" + message_for_choose
    start_search = gets.chomp
    while %w[y n].none?(start_search)
      puts "\nYou must choose a valid option. #{message_for_choose}"
      start_search = gets.chomp
    end
    start_search
  end
end
