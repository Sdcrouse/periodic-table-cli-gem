class PeriodicTable::CLI 
  def call 
    # call the scraper here
    start
    puts "\nUntil next time, future chemist!"
  end
  
  def start
    puts "Welcome to the Interactive Periodic Table!"
    puts "Ready to start learning some chemistry? (Y/n)"
    start_program = gets.strip.downcase
    
    main_menu unless start_program == "n" || start_program == "no"
  end
  
  def main_menu
    options = {1 => "Help", 2 => "List Elements", 3 => "Quit"}
    yes_or_no = "no"
    user_choice = nil
    
    until yes_or_no == "y" || yes_or_no == "yes"
      puts "\nWelcome to the Main Menu! Here are your options:"
      options.each {|key, value| puts "#{key}. #{value}"}
      
      puts "\nWhat would you like to do? Choose from 1-3:"
      user_choice = gets.strip.to_i
      
      case user_choice
      when 1 
        help 
      when 2 
        list_elements 
      when 3 
        puts "Are you sure you want to quit? (N/y):"
        yes_or_no = gets.strip.downcase
      else 
        puts "I don't understand. Please try again."
      end
    end
  end
  
  def help 
    puts "The user was helped."
  end
  
  def list_elements 
    puts "The elements have been listed"
  end
end