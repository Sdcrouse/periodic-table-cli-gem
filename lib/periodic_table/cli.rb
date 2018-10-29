class PeriodicTable::CLI
  def call
    make_elements
    start
    puts "\nUntil next time, future chemist!"
  end

  def make_elements
    elements_array = PeriodicTable::TableScraper.new.scrape_periodic_table
    
    elements_array.each do |element| 
      PeriodicTable::Element.new_from_periodic_table(element)
    end
  end
  
  def start
    puts "Welcome to the Interactive Periodic Table!"
    puts "Ready to start learning some chemistry? (Y/n)"
    start_program = gets.strip.downcase

    main_menu unless start_program == "n" || start_program == "no"
  end

  def main_menu # Refactor the program so that most of it is run from here, including the options to examine an element and sort elements.
    menu_options = ["List Elements", "Examine an Element", "Sort Elements", "Help", "Quit"]
    yes_or_no = "no"
    user_choice = nil

    until yes_or_no == "y" || yes_or_no == "yes"
      puts "\nWelcome to the Main Menu! What would you like to do?"
      user_choice = self.choose_from(menu_options)

      case user_choice
      when 1
        list_elements
      when 2
        #examine_element
      when 3 
        sort_elements
      when 4 
        help
      when 5
        puts "\nAre you sure you want to quit? (N/y):"
        yes_or_no = gets.strip.downcase
      else
        puts "I don't understand. Please try again."
      end
    end
  end

  def choose_from(option_list)
    puts "Choose from the numbered list below:\n\n"
    option_list.each.with_index(1) do |option, i| 
      puts "#{i}. #{option}"
      sleep 0.5 
    end
    gets.strip.to_i
  end

  def help # Note: I slowed these methods down to give the user more time to read.
    introduction
    describe_main_menu_options
  end

  def introduction
    puts "\nThe Interactive Periodic Table is designed to mimic a real periodic table by providing information about each of the currently known chemical elements."
    sleep 5
    puts "\nIn this program, you are able to view a list of all or some of the chemical elements, examine an individual chemical element for more information, and sort the elements. Currently, the elements can only be sorted by name."
    sleep 5
  end

  def describe_main_menu_options
    puts "\nHere are the Main Menu options:"
    sleep 1
    puts "Press 1 to view a list of chemical elements from the Periodic Table."
    sleep 1
    puts "Press 2 to get more information about an element (name, symbol, properties, etc)."
    sleep 1
    puts "Press 3 to see the chemical elements sorted by name."
    sleep 1
    puts "Press 4 to view this description of the Main Menu options."
    sleep 1
    puts "Press 5 to quit the Interactive Periodic Table."
    sleep 3
  end

  def list_elements
    user_choice = nil
    list_choices = [
      "List elements without their properties",
      "List elements with their properties",
      "Sort elements",
      "Help",
      "Return to Main Menu"
    ]

    puts "\nHere's where the REAL fun begins!"
    until user_choice == 5
      puts "How do you want to list the elements?"
      user_choice = self.choose_from(list_choices)
      puts "\n"

      case user_choice
      when 1
        list_elements_without_properties
      when 2
        #list_elements_with_properties
      when 3 
        sort_elements
      when 4
        #list_elements_help
      when 5 # Return to Main Menu
      else
        puts "I don't understand. Please try again."
      end
    end
  end

  def list_elements_without_properties
    options = ["Elements 1-10", "Elements 11-20", "Elements 21-30", "Elements 31-40", "Elements 41-50", "Elements 51-60", "Elements 61-70", "Elements 71-80", "Elements 81-90", "Elements 91-100", "Elements 101-110", "Elements 111-118", "All Elements", "Go Back"]
    user_choice = nil

    until user_choice == 14
      puts "Which elements would you like to see?"
      user_choice = choose_from(options)
      puts "\n"
      
      # Refactor part of this into a method that works like a book (i.e. includes the #choices First, Previous, Next, and Last)
      # Be sure to puts "\n" after displaying them. 
      
      if user_choice.between?(1,12)
        display_set_of_ten_elements(user_choice)
      elsif user_choice == 13 
        display_all_elements(PeriodicTable::Element.all)
      elsif user_choice == 14 
        # Go back to #list_elements 
      else
        puts "I don't understand. Please try again."
      end
      puts "\n"
    end
  end
  
  def display_set_of_ten_elements(set_number) 
    # Example: if set_number == 2, then do this:
    # PeriodicTable::Element.all[10..19].each.with_index(11) {|element, i| puts "#{i}. #{element.name}"}
    
    first = (set_number - 1) * 10
    index = first + 1
    
    last = nil 
    if set_number == 12 
      last = 117 # There are only 118 elements, so the last set contains 8, not 10
    else 
      last = first + 9
    end
    
    PeriodicTable::Element.all[first..last].each.with_index(index) do |element, i| 
      puts "#{i}. #{element.name}"
      sleep 0.5
    end
  end
  
  def display_all_elements(element_list) 
    element_list.each.with_index(1) do |element, i| 
      puts "#{i}. #{element.name}"
      sleep 0.5
    end
  end

  def list_elements_with_properties
    # Maybe split this into #basic_properties and #more_properties...
    # Since there are a lot of properties, I may use #sleep between each property for easier viewing.
    PeriodicTable::Element.all.each.with_index(1) do |element, i|
      puts "--------------------------------------"
      puts "Element #{i}\n\n"
      puts "Name: #{element.name}"
      puts "Element Type: #{element.element_type}"
      puts "Origin of Name: #{element.name_origin}"
      puts "Symbol: #{element.symbol}"
      puts "Atomic Number: #{element.atomic_number}"
      puts "Atomic Weight: #{element.atomic_weight}"
      puts "Group: #{element.group}"
      puts "Period: #{element.period}"
      puts "Density: #{element.density} g/cm^3"
      puts "Melting Point: #{element.melting_point} K"
      puts "Boiling Point: #{element.boiling_point} K"
      puts "Heat Capacity: #{element.heat_capacity} J/(g * K)"
      puts "Electronegativity (Pauline Scale): #{element.electronegativity}"
      puts "Abundance in Earth's Crust: #{element.abundance} mg/kg"
      puts "URL: #{element.element_url}"
      puts "--------------------------------------"
    end
    puts "\n"
  end
  
  def sort_elements 
    sorted_elements = PeriodicTable::Element.all.sort_by{|element| element.name}
    display_all_elements(sorted_elements)
  end
end
