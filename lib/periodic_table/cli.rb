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
    introduction 
    describe_main_menu_options
  end
  
  def introduction 
    puts "\nThe Interactive Periodic Table is designed to mimic a real periodic table by providing information about each of the currently known chemical elements."
    puts "\nIn this program, you are able to view a list of all the chemical elements, sort the list by a category of your choosing, and examine an individual element for more information." 
    puts "\nPlease note that you are unable to sort the list or view an individual element unless you choose option 2 from the Main Menu."
  end 
  
  def describe_main_menu_options 
    puts "\nHere are the Main Menu options:"
    puts "Press 1 to view this description of the Main Menu options."
    puts "Press 2 to list all of the chemical elements in the Periodic Table."
    puts "Press 3 to quit the Interactive Periodic Table."
  end
  
  def list_elements 
    elements = ["hydrogen", "helium", "carbon", "oxygen", "nitrogen", "sulfur", "astatine", "phosphorus", "neon", "xenon", "iron", "lead", "silver", "gold", "sodium"]
    i = 0
    elements.each {|element| puts "#{i}. #{element}"; i += 1}
    puts "The elements have been listed"
  end
end