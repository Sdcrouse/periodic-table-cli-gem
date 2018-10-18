require "pry"

class PeriodicTable::CLI
  attr_reader :elements 
  
  def initialize # Remember to update this with a list of Elements
    @elements = ["hydrogen", "helium", "carbon", "oxygen", "nitrogen", "sulfur", "astatine", "phosphorus", "neon", "xenon", "iron", "lead", "silver", "gold", "sodium"]
  end 
  
  def call 
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
    
    #call PeriodicTable::Table here. That should then scrape Wikipedia.
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
    sleep 1
    puts "\nIn this program, you are able to view a list of all the chemical elements, sort the list by a category of your choosing, and examine an individual element for more information." 
    sleep 1
    puts "\nPlease note that you are unable to sort the list or view an individual element unless you choose option 2 from the Main Menu."
    sleep 1
  end 
  
  def describe_main_menu_options 
    puts "\nHere are the Main Menu options:"
    puts "Press 1 to view this description of the Main Menu options."
    puts "Press 2 to list all of the chemical elements in the Periodic Table."
    puts "Press 3 to quit the Interactive Periodic Table."
    sleep 1
  end
  
  def list_elements 
    user_choice = nil
    list_choices = {
      1 => "List elements without their properties",
      2 => "List elements with their properties",
      3 => "List element periods",
      4 => "List element groups",
      5 => "List element categories",
      6 => "Help",
      7 => "Return to Main Menu"
    }
    
    until user_choice == 7
      puts "\nHere are your choices for listing the elements:"
      list_choices.each {|key, value| puts "#{key}. #{value}"}
      
      puts "\nWhat would you like to do? Choose from the numbered list above:"
      user_choice = gets.strip.to_i
      
      case user_choice 
      when 1 
        list_elements_without_properties
      when 2 
        #list_elements_with_properties 
      when 3 
        #list_periods 
      when 4 
        #list_groups
      when 5 
        #list_categories 
      when 6 
        #list_elements_help 
      when 7 # Return to Main Menu 
      else 
        puts "I don't understand. Please try again."
      end
    end
  end
  
  def list_elements_without_properties # Refactor this! Have the option to list only a few elements. Also, update this when I get all 118 elements.
    options = {1 => "Elements 1-5", 2 => "Elements 6-10", 3 => "Elements 11-15", 4 =>"All Elements", 5 => "Go Back"}
    user_choice = nil
    
    until user_choice == 5
      puts "\nHere are your options:"
      options.each {|key, value| puts "#{key}. #{value}"}
      puts "\nWhat would you like to do? Choose a number from the list above:"
      user_choice = gets.strip.to_i
      
      case user_choice # Refactor part of this into a method that works like a book (i.e. includes the choices First, Previous, Next, and Last)
      # Also, displaying ten elements instead of five is doable.
      when 1
        self.elements[0..4].each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 2 
        self.elements[5..9].each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 3 
        self.elements[10..14].each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 4 
        self.elements.each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 5 # Go back to #list_elements
      else 
        puts "I don't understand. Please try again."
      end
      sleep 1
    end
  end
end