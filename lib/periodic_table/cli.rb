class PeriodicTable::CLI
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
    until ["Y", "YES", "N", "NO"].include?(start_program)
      puts "Welcome to the Interactive Periodic Table!".colorize(:light_red)
      puts "Ready to start learning some chemistry? (Y/N)\n".colorize(:light_red)
      start_program = gets.strip.upcase
      
      if start_program == "Y" || start_program == "YES"
        main_menu 
      elsif start_program == "N" || start_program == "NO"
        next
      else 
        puts "\nI don't understand what you're saying. Please try again.\n".colorize(:light_red)
      end
    end
  end

  def main_menu
    menu_options = ["View a List of Chemical Elements", "List the Element Names Alphabetically", "Examine an Element", "Help", "Quit"]
    selected_option = nil
    exit_program = nil
    
    puts "\nHere's where the REAL fun begins!".colorize(:light_yellow)

    until exit_program == "Y" || exit_program == "YES"
      puts "\nWelcome to the Main Menu! What would you like to do?".colorize(:light_yellow)
      selected_option = choose_from(menu_options)

      case selected_option
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
  
  def list_elements
    list_elements_v2
    #options = ["Elements 1-10", "Elements 11-20", "Elements 21-30", "Elements 31-40", #"Elements 41-50", "Elements 51-60", "Elements 61-70", "Elements 71-80", "Elements #81-90", "Elements 91-100", "Elements 101-110", "Elements 111-118", "All of them!", #"Back to Main Menu"]
    #chosen_option_number = nil
    #
    #until chosen_option_number == 14
    #  puts "\nWhich elements would you like to see?".colorize(:light_magenta)
    #  chosen_option_number = choose_from(options)
    #  puts "\n"
    #  
    #  if chosen_option_number.between?(1,12)
    #    display_set_of_elements(chosen_option_number)
    #    puts "\nWould you like to examine one of these elements? (Y/n):\n\n"
    #    yes_or_no = gets.strip.upcase
    #    if ["Y", "YES"].include?(yes_or_no)
    #      puts "\nWhich element would you like to examine? Choose from 1-10:\n\n"
    #      element_number = gets.strip.to_i
    #      if element_number.between?(1,10)
    #        element = PeriodicTable::Element.find_element_by_atomic_number(element_number#)
    #        list_properties_of(element)
    #      else
    #        puts "\nI don't understand your choice. Please try again."
    #      end
    #    end
    #  elsif chosen_option_number == 13 
    #    display_all_elements(PeriodicTable::Element.all)
    #  elsif chosen_option_number == 14 
    #    puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
    #  else
    #    puts "I don't understand. Please try again.".colorize(:light_magenta)
    #  end
    #end
  end
  
  def list_elements_alphabetically 
    puts "\n"
    sorted_elements = PeriodicTable::Element.all.sort_by{|element| element.name}
    display_all_elements(sorted_elements)
  end

  def help # Note: I slowed these methods down to give the user more time to read.
    introduction
    describe_main_menu_options
  end

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
  
  def quit?
    yes_or_no = nil
    
    until ["Y", "YES", "N", "NO"].include?(yes_or_no)
      puts "\nAre you sure you want to quit? (Y/N):\n".colorize(:light_yellow)
      yes_or_no = gets.strip.upcase
      
      unless ["Y", "YES", "N", "NO"].include?(yes_or_no)
        puts "\nI don't understand your answer. Please try again.".colorize(:light_yellow)
      end
    end
    
    yes_or_no
  end
  
  def list_elements_v2
    
    selected_option = nil
    element_total = PeriodicTable::Element.all.size
    
    puts "\nHow many elements would you like to see? Please enter a number, or type 'all' to see them all. To go back to the Main Menu, type 'back'.\n".colorize(:light_magenta)
    selected_option = gets.strip.capitalize
    elements_per_page = selected_option.to_i
    puts "\n"
    
    if elements_per_page.between?(1, element_total - 1)
      page_total = element_total / elements_per_page
      page_total += 1 unless element_total % elements_per_page == 0
      yes_or_no = nil
      
      puts "\nWhich page of elements would you like to see? Choose from 1-#{page_total}.\n".colorize(:light_magenta)
      page_number = gets.strip.to_i
      
      if page_number.between?(1, page_total)
        display_page_of_elements(page_number, page_total, elements_per_page, element_total)
      else 
        puts "\nSorry. That is an invalid choice. Please try again.".colorize(:light_magenta)
      end
      
      until ["N", "No"].include?(yes_or_no)
        puts "\nWould you like to examine one of these elements? (Y/n):\n\n"
        yes_or_no = gets.strip.capitalize
        
        if ["Y", "Yes"].include?(yes_or_no)
          examine_element_from_list((1..10).to_a) # This stub is temporary
        elsif ["N", "No"].include?(yes_or_no)
          next 
        else 
          puts "\nI don't understand your choice. Please try again."
        end
      end
    elsif selected_option == "All" || elements_per_page == element_total
      display_all_elements_v2(PeriodicTable::Element.all, 1)
      # Ask the user to examine an element here.
    elsif selected_option == "Back" 
      puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
    else
      puts "I don't understand. Please try again.".colorize(:light_magenta)
    end
  end
  
  def display_page_of_elements(page_number, page_total, elements_per_page, element_total)
    # If you want to display page 1 with 40 elements, then display Elements 1-40
    # If you want to display page 2 with 40 elements, then display Elements 41-80
    # If you want to display the last page (page 3) with 118 - 2 * 40 = 38 Elements, then display elements 81-118.
    # The last page of elements has element_total % elements_per_page elements.
    # However, if element_total % elements_per_page == 0, then the last page has elements_per_page elements
    # I need a selector. Something like PeriodicTable::Element.select_elements(first, last)
    
    # For 4 pages, each containing 20 elements, for a total of 80 elements, we have:
    # Page 1: Elements 1-20 => first_element_number = 1 = (1-1) * 20 + 1, last_element_number = 1 * 20
    # Page 2: Elements 21-40 => first_element_number = 21 = 1 * 20 + 1 = (2 - 1) * 20 + 1, last_element_number = 40 = 2 * 20
    # Page 3: Elements 41-60 => first_element_number = 41 = 40 + 1 = 2 * 20 + 1 = (3 - 1) * 20 + 1, last_element_number = 60 = 3 * 20
    # Page 4: Elements 61-80 => first_element_number = 61 = 3 * 20 + 1 = (4 - 1) * 20 + 1, last_element_number = 4 * 20
    # So, how do the first and last elements relate to the current page and page total?
    # It appears that first_element_number = (page_number - 1) * elements_per_page + 1, and last_element_number = page_number * elements_per_page
    # Or, first_element_number = last_element_number - elements_per_page + 1
    # Maybe it would be easier to somehow keep track of the previous page?
    
    #first, last = 0, 0
    
    if page_number == page_total
      last_element_number = element_total
      final_element_group = element_total % elements_per_page
      
      if final_elements == 0 
        first_element_number = element_total - elements_per_page + 1 # 118 - 59 + 1 = 60
      else 
        first_element_number = element_total - final_element_group + 1 # 118 - 8 + 1 = 111
      end
    else 
      last_element_number = elements_per_page * page_number
      first_element_number = last_element_number - elements_per_page + 1
    end
    
    display_all_elements_v2(PeriodicTable::Element.select_elements_by_atomic_number(first_element_number, last_element_number), first_element_number)
    #puts "The page of elements has been displayed."
  end
  
  def display_set_of_elements(number_of_elements) 
    # Example: if number_of_elements == 2, then do this to puts Elements 11-19:
    # PeriodicTable::Element.all[10..19].each.with_index(11) {|element, i| puts "#{i}. #{element.name}"}
    
    first_element_number = (number_of_elements - 1) * 10
    first_element_index = first_element_number + 1
    
    last_element_number = nil 
    if number_of_elements == 12 
      last_element_number = 117 # There are only 118 elements, so the last set contains 8, not 10
    else 
      last_element_number = first_element_number + 9
    end
    
    PeriodicTable::Element.all[first_element_number..last_element_number].each.with_index(first_element_index) do |element, i| 
      puts "#{i}. #{element.name}".colorize(:yellow)
      sleep 0.25
    end
    sleep 0.5
  end
  
  def display_all_elements(element_list) 
    element_list.each.with_index(1) do |element, i| 
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.25
    end
    sleep 1
  end
  
  def display_all_elements_v2(element_list, first_element_index)
    element_list.each.with_index(first_element_index) do |element, i|
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.25
    end
    sleep 1
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
  
  def examine_element_from_list(element_range) 
    chosen_element_number = nil 
    
    until chosen_element_number == "Back"
      puts "Which element would you like to examine? Choose from #{element_range.first} - #{element_range.last}, or type 'back' to go back to the previous option:"
      chosen_element_number = gets.strip.capitalize
    
      if chosen_element_number.to_i.between?(element_range.first, element_range.last)
        element = PeriodicTable::Element.find_element_by_atomic_number(chosen_element_number)
        list_properties_of(element)
      elsif chosen_element_number == "Back"
        next # Back to the previous choice
      else
        puts "I don't understand your choice. Please try again."
      end
    end
  end

  def list_properties_of(element)
    element_attribute_collection = make_element_attribute_collection_from(element)
    
    puts "\n---------------------------------------------------------------------------"
    puts "Element: #{element.name}\n".colorize(:light_red)
    
    element_attribute_collection.each {|attribute_hash| display_attribute_from(attribute_hash)}
    
    puts "\nURL: #{element.element_url}".colorize(:light_green)
    puts "---------------------------------------------------------------------------"
    sleep 1
  end
  
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
