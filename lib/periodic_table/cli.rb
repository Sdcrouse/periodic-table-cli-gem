class PeriodicTable::CLI
  #----------------------------Initial Methods--------------------------------
  
  def call
    make_elements
    start
    puts "\nUntil next time, future chemist!".colorize(:light_cyan)
  end

  def make_elements
    elements_array = PeriodicTable::TableScraper.scrape_periodic_table
    
    elements_array.each do |element_attributes_hash| 
      PeriodicTable::Element.new_from_periodic_table(element_attributes_hash)
    end
  end
  
  def start
    start_program = nil
    until ["Y", "Yes", "N", "No"].include?(start_program)
      puts "Welcome to the Interactive Periodic Table!".colorize(:light_red)
      puts "Ready to start learning some chemistry? (Y/N)\n".colorize(:light_red)
      start_program = gets.strip.capitalize
      
      if ["Y", "Yes"].include?(start_program)
        main_menu 
      elsif ["N", "No"].include?(start_program)
        next
      else 
        puts "\nI don't understand what you're saying. Please try again.\n".colorize(:light_red)
      end
    end
  end

  def main_menu
    menu_options = ["View a List of Chemical Elements", "List the Element Names Alphabetically", "Examine an Element", "Help", "Quit"]
    exit_program = nil
    
    puts "\nHere's where the REAL fun begins!".colorize(:light_yellow)

    until ["Y", "Yes"].include?(exit_program)
      puts "\nWelcome to the Main Menu! What would you like to do?".colorize(:light_yellow)
      selected_menu_option = choose_from(menu_options)

      case selected_menu_option
      when 1
        list_elements
      when 2
        list_elements_alphabetically
      when 3 
        examine_element_from_main_menu
      when 4 
        help
      when 5
        exit_program = quit?
      else
        puts "\nI don't understand. Please try again.".colorize(:light_yellow)
      end
    end
  end

  def choose_from(option_list)
    puts "Choose from the numbered list below:\n".colorize(:light_green)
    
    option_list.each.with_index(1) do |option, i| 
      puts "#{i}. #{option}".colorize(:light_green)
      sleep 0.25 
    end
    puts "\n"
    
    gets.strip.to_i
  end
  
  #----------------------------Main Menu Options--------------------------------
  
  def list_elements
    selected_option = nil
    element_total = PeriodicTable::Element.all.size
    
    until selected_option == "Back"
      puts "\nHow many elements would you like to see? Please enter a number, or type 'all' to see them all. To go back to the Main Menu, type 'back'.\n".colorize  (:light_magenta)
      
      selected_option = gets.strip.capitalize
      elements_per_page = selected_option.to_i
      
      puts "\n"
      
      if elements_per_page.between?(1, element_total - 1)
        page_total = element_total / elements_per_page
        page_total += 1 unless element_total % elements_per_page == 0
        page_number = nil
        
        until page_number == "Back"
          puts "Which page of elements would you like to see? Choose from 1-#{page_total}, or type 'back' to go back to the previous option.\n".colorize(:light_magenta)
          page_number = gets.strip.capitalize
          
          if page_number.to_i.between?(1, page_total)
            page_of_elements = get_page_of_elements(page_number.to_i, page_total, elements_per_page, element_total)
            
            puts "\n"
            display_all_elements(PeriodicTable::Element.select_elements_by_atomic_number(page_of_elements.first, page_of_elements.last), page_of_elements.first)
            
            ask_user_to_examine_element(page_of_elements)
            puts "\n"
          elsif page_number == "Back"
            next
          else
            puts "Sorry. That is an invalid choice. Please try again.".colorize  (:light_magenta)
          end
        end
      elsif selected_option == "All" || elements_per_page == element_total
        display_all_elements(PeriodicTable::Element.all, 1)
        ask_user_to_examine_element((1..element_total).to_a)
      elsif selected_option == "Back" 
        puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
      else
        puts "I don't understand. Please try again.".colorize(:light_magenta)
      end
    end
  end
  
  def list_elements_alphabetically 
    puts "\n"
    sorted_elements = PeriodicTable::Element.all.sort_by{|element| element.name}
    display_all_elements(sorted_elements)
  end

  def examine_element_from_main_menu
    element_to_examine = nil
    
    until element_to_examine == "Back"
      puts "\nWhich element would you like to examine?".colorize(:light_blue)
      puts "Please enter its name here, or type 'back' to go back to the Main Menu:\n".colorize(:light_blue)
      
      element_to_examine = gets.strip.capitalize
      element_from_table = PeriodicTable::Element.find_element_by_name(element_to_examine)
      
      if !element_from_table.nil?
        list_properties_of(element_from_table)
      elsif element_to_examine == "Back"
        puts "\nOK. Back to the Main Menu we go!".colorize(:light_blue)
      else 
        puts "\nI'm sorry. I do not recognize that element.".colorize(:light_blue) 
        puts "Please be careful to spell its name correctly.".colorize(:light_blue)
      end
    end
  end
  
  def help # Note: I slowed these methods down to give the user more time to read.
    introduction
    describe_main_menu_options
  end
  
  def quit?
    yes_or_no = nil
    
    until ["Y", "Yes", "N", "No"].include?(yes_or_no)
      puts "\nAre you sure you want to quit? (Y/N):\n".colorize(:light_yellow)
      yes_or_no = gets.strip.capitalize
      
      unless ["Y", "Yes", "N", "No"].include?(yes_or_no)
        puts "\nI don't understand your answer. Please try again.".colorize(:light_yellow)
      end
    end
    
    yes_or_no
  end
  
  #-----Helper Method for #list_elements and #list_elements_alphabetically-----
  
  def display_all_elements(element_list, first_element_index = 1) 
    element_list.each.with_index(first_element_index) do |element, i| 
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.25
    end
    sleep 1
  end
  
  #---------------------Helper Methods for #list_elements-------------------------
  
  def get_page_of_elements(page_number, page_total, elements_per_page, element_total)
    first_element_index, last_element_index = 0, 0
    
    if elements_per_page > element_total # Edge case 1
      raise StandardError, "The specified number of chemical elements per page is more than the number of known chemical elements."
    elsif page_number > page_total # Edge case 2
      raise StandardError, "The specified page number is more than the total number of pages."
    end
    
    if page_number == page_total
      last_element_index = element_total
      number_of_elements_on_last_page = element_total % elements_per_page
      
      if number_of_elements_on_last_page == 0 
        first_element_index = element_total - elements_per_page + 1 
      else 
        first_element_index = element_total - number_of_elements_on_last_page + 1 
      end
    else 
      last_element_index = elements_per_page * page_number
      first_element_index = last_element_index - elements_per_page + 1
    end
    
    (first_element_index..last_element_index).to_a
  end
  
  def ask_user_to_examine_element(page_of_elements)
    yes_or_no = nil
    
    until ["N", "No"].include?(yes_or_no)
      puts "\nWould you like to examine one of these elements? (Y/N):\n\n"
      yes_or_no = gets.strip.capitalize
      
      if ["Y", "Yes"].include?(yes_or_no)
        examine_element_from_list(page_of_elements)
        #yes_or_no = "No"
      elsif ["N", "No"].include?(yes_or_no)
        next 
      else 
        puts "\nI don't understand your choice. Please try again."
      end
    end
  end
  
  #-------------Helper method for #ask_user_to_examine_element----------------
  
  def examine_element_from_list(element_range) 
    chosen_element_number = nil 
    
    until chosen_element_number == "Back"
      puts "\nWhich element would you like to examine? Choose from #{element_range.first} - #{element_range.last}, or type 'back' to go back to the previous option:\n\n"
      chosen_element_number = gets.strip.capitalize
    
      if chosen_element_number.to_i.between?(element_range.first, element_range.last)
        element = PeriodicTable::Element.find_element_by_atomic_number(chosen_element_number)
        
        list_properties_of(element)
        #examine_another_element(element_range)
        #
        #chosen_element_number = "Back" 
        # The line above will let the program go back to the previous option.
      elsif chosen_element_number == "Back"
        next # Exit this method and go back to the previous choice.
      else
        puts "\nI don't understand your choice. Please try again."
      end
    end
  end

  # Helper Method for #examine_element_from_main_menu and #examine_element_from_list:
  
  def list_properties_of(element)
    element_attribute_collection = make_element_attribute_collection_from(element)
    
    puts "\n---------------------------------------------------------------------------"
    puts "Element: #{element.name}\n".colorize(:light_red)
    
    element_attribute_collection.each {|attribute_hash| display_attribute_from(attribute_hash)}
    
    puts "\nURL: #{element.element_url}".colorize(:light_green)
    puts "---------------------------------------------------------------------------"
    sleep 1
  end
  
  #-----------------Helper Methods for #list_properties_of------------------
  
  def make_element_attribute_collection_from(element)
    [
      {"Atomic Number" => element.atomic_number, "color" => :light_yellow},
      {"Symbol" => element.symbol, "color" => :light_green},
      {"Atomic Weight" => element.atomic_weight, "color" => :light_cyan},
      {"Origin of Name" => element.name_origin, "color" => :light_blue},
      {"Element Type" => element.element_type, "color" => :light_magenta},
      {"Group" => element.group, "color" => :light_red},
      {"Period" => element.period, "color" => :light_yellow},
      {"Density (g/cm^3)" => element.density, "color" => :light_green},
      {"Melting Point (K)" => element.melting_point, "color" => :light_cyan},
      {"Boiling Point (K)" => element.boiling_point, "color" => :light_blue},
      {"Heat Capacity (J/(g * K))" => element.heat_capacity, "color" => :light_magenta},
      {"Electronegativity (Pauline Scale)" => element.electronegativity, "color" =>  :light_red}, 
      {"Abundance in Earth's Crust (mg/kg)" => element.abundance, "color" => :light_yellow}
    ]
  end
  
  def display_attribute_from(attribute_hash)
    key = attribute_hash.keys.first # "Atomic Number", "Symbol", "Period", etc.
    value = attribute_hash.values.first # element.atomic_number, element.symbol, etc.
    
    puts "#{key}: #{value}".strip.colorize(attribute_hash["color"])
    sleep 0.5
  end
end

#----------------Helper Method for #examine_element_from_list------------------
  
  #def examine_another_element(page_of_elements) 
  # This is commented out until I can figure out where and when to call it.
  
  #  examine_again = nil
  #  until ["N", "No"].include?(examine_again)
  #    puts "\nWould you like to examine another element? (Y/N):\n\n"
  #    examine_again = gets.strip.capitalize 
  #    
  #    if ["Y", "Yes"].include?(examine_again)
  #      examine_element_from_list(page_of_elements)
  #      examine_again = "No" 
  #      # This starts a chain of returns that eventually ends at #list_elements.
  #      # This works due to the way that this method and #examine_element_from_list call #each other.
  #    elsif ["N", "No"].include?(examine_again)
  #      # Go back
  #    else 
  #      puts "\nCould you say that again? I didn't quite understand you."
  #    end
  #  end
  #end
  
  #---------------------------Helper Methods for #help-----------------------------
  
  def introduction
    puts "\nThe Interactive Periodic Table is designed to mimic a real periodic table by providing information about each of the currently known chemical elements.".colorize(:light_red)
    sleep 5
    
    puts "\nIn this program, you are able to view a list of all or some of the chemical elements, list the names of the chemical elements alphabetically, and examine an individual chemical element for more information.".colorize(:light_red)
    sleep 5
    
    puts "\nAs a side note, by default the chemical elements are listed by their atomic numbers.".colorize(:light_red)
    sleep 3
  end

  def describe_main_menu_options
    puts "\nHere are the Main Menu options:".colorize(:light_yellow)
    sleep 1
    
    puts "Press 1 to view a list of chemical elements from the Periodic Table.".colorize(:light_yellow)
    sleep 1
    
    puts "Press 2 to see the names of the chemical elements listed in alphabetical order.".colorize(:light_yellow)
    sleep 1
    
    puts "Press 3 to get more information about an element (name, properties, etc).".colorize(:light_yellow)
    sleep 1
    
    puts "Press 4 to view this description of the Main Menu options.".colorize(:light_yellow)
    sleep 1
    
    puts "Press 5 to quit the Interactive Periodic Table.".colorize(:light_yellow)
    sleep 3
  end
