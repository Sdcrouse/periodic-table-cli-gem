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
    options = {1: "Quit"}
    yes_or_no = "no"
    user_choice = nil
    
    puts "Welcome to the Main Menu! Here are your options:"
    puts "Option 1, Option 2, Option 3"
    
    puts "What would you like to do?"
  end
end