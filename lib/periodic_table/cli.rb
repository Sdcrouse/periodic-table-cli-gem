class PeriodicTable::CLI
  def call
    make_elements
    start
    puts "\nUntil next time, future chemist!".colorize(:light_cyan)
  end

  def make_elements
    elements_array = PeriodicTable::TableScraper.scrape_periodic_table
    
    elements_array.each do |element| 
      PeriodicTable::Element.new_from_periodic_table(element)
    end
  end
  
  def start
    puts "Welcome to the Interactive Periodic Table!".colorize(:light_red)
    puts "Ready to start learning some chemistry? (Y/n)\n".colorize(:light_red)
    start_program = gets.strip.downcase

    main_menu unless start_program == "n" || start_program == "no"
  end

  def main_menu
    menu_options = ["View a List of Chemical Elements", "List the Element Names Alphabetically", "Examine an Element", "Help", "Quit"]
    yes_or_no = "no"
    user_choice = nil
    
    puts "\nHere's where the REAL fun begins!".colorize(:light_yellow)

    until yes_or_no == "y" || yes_or_no == "yes"
      puts "\nWelcome to the Main Menu! What would you like to do?".colorize(:light_yellow)
      user_choice = choose_from(menu_options)

      case user_choice
      when 1
        list_elements
      when 2
        list_elements_alphabetically
      when 3 
        examine_element
      when 4 
        help
      when 5
        puts "\nAre you sure you want to quit? (N/y):\n".colorize(:light_yellow)
        yes_or_no = gets.strip.downcase
      else
        puts "I don't understand. Please try again.".colorize(:light_yellow)
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

  def list_elements
    binding.pry
    options = ["Elements 1-10", "Elements 11-20", "Elements 21-30", "Elements 31-40", "Elements 41-50", "Elements 51-60", "Elements 61-70", "Elements 71-80", "Elements 81-90", "Elements 91-100", "Elements 101-110", "Elements 111-118", "All of them!", "Back to Main Menu"]
    user_choice = nil
    
    until user_choice == 14
      puts "\nWhich elements would you like to see?".colorize(:light_magenta)
      user_choice = choose_from(options)
      puts "\n"
      
      if user_choice.between?(1,12)
        display_set_of_elements(user_choice)
        puts "Would you like to examine one of these elements? (Y/n):"
        input = gets.strip.upcase
        if ["Y", "YES"].include?(input)
          puts "Which element would you like to examine? Choose from 1-10:"
          choice = gets.strip.to_i
          if choice.between?(1,10)
            element = PeriodicTable::Element.find_element_by_atomic_number(choice)
            list_properties_of(element)
          else
            puts "I don't understand your choice. Please try again."
          end
        end
      elsif user_choice == 13 
        display_all_elements(PeriodicTable::Element.all)
      elsif user_choice == 14 
        puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
      else
        puts "I don't understand. Please try again.".colorize(:light_magenta)
      end
    end
  end
  
  def list_elements_v2
    
    user_input = nil
    element_total = PeriodicTable::Element.all.size
    
    puts "\nHow many elements would you like to see? Please enter a number, or type 'all' to see them all. To go back to the Main Menu, type 'back'.".colorize(:light_magenta)
    user_input = gets.strip.capitalize
    elements_per_page = user_input.to_i
    puts "\n"
    
    if input_to_number.between?(1, element_total - 1)
      page_total = element_total / elements_per_page
      page_total += 1 unless element_total % elements_per_page == 0
      
      puts "Which page of elements would you like to see? Choose from 1-#{number_of_pages}."
      page = gets.strip.to_i
      
      if page.between?(1..page_total)
        display_page_of_elements(page, page_total, elements_per_page, element_total)
      else 
        puts "Sorry. That is an invalid choice. Please try again."
      end
      
      #puts "Would you like to examine one of these elements? (Y/n):"
      #input = gets.strip.capitalize
      #if ["Y", "Yes"].include?(input)
      #  puts "Which element would you like to examine? Choose from 1-10:"
      #  choice = gets.strip.to_i
      #  if choice.between?(1,10)
      #    element = PeriodicTable::Element.find_element_by_atomic_number(choice)
      #    list_properties_of(element)
      #  else
      #    puts "I don't understand your choice. Please try again."
      #  end
      #end
    elsif user_input == "All" || elements_per_page == element_total
      display_all_elements_v2(PeriodicTable::Element.all, 1)
    elsif user_input == "Back" 
      puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
    else
      puts "I don't understand. Please try again.".colorize(:light_magenta)
    end
  end
  
  def display_page_of_elements(page, page_total, elements_per_page, element_total)
    # If you want to display page 1 with 40 elements, then display Elements 1-40
    # If you want to display page 2 with 40 elements, then display Elements 41-80
    # If you want to display the last page (page 3) with 118 - 2 * 40 = 38 Elements, then display elements 81-118.
    # The last page of elements has element_total % elements_per_page elements.
    # However, if element_total % elements_per_page == 0, then the last page has elements_per_page elements
    # I need a selector. Something like PeriodicTable::Element.select_elements(first, last)
    
    # For 4 pages, each containing 20 elements, for a total of 80 elements, we have:
    # Page 1: Elements 1-20 => first = 1, last = 20
    # Page 2: Elements 21-40 => first = 21 = 2 * 20 + 1, last = 40 = 2 * 20
    # Page 3: Elements 41-60
    # Page 4: Elements 61-80
    # So, how do the first and last elements relate to the current page and page total?
    
    first, last = 0, 0
    
    if page == page_total
      last = element_total
      final_elements = element_total % elements_per_page
      
      if final_elements == 0 
        first = element_total - elements_per_page + 1 # 118 - 59 + 1 = 60
      else 
        first = element_total - final_elements + 1 # 118 - 8 + 1 = 111
      end
    elsif page == 1 
      first = 1
      last = elements_per_page
    else 
      first = elements_per_page + 1
      last = elements_per_page * page
    end
    
    display_all_elements_v2(PeriodicTable::Element.find_elements_by_atomic_number(first, last), first)
    #puts "The page of elements has been displayed."
  end
  
  def display_set_of_elements(number_of_elements) 
    # Example: if number_of_elements == 2, then do this to puts Elements 11-19:
    # PeriodicTable::Element.all[10..19].each.with_index(11) {|element, i| puts "#{i}. #{element.name}"}
    
    puts "The elements have been displayed."
    
    #first = (number_of_elements - 1) * 10
    #index = first + 1
    #
    #last = nil 
    #if number_of_elements == 12 
    #  last = 117 # There are only 118 elements, so the last set contains 8, not 10
    #else 
    #  last = first + 9
    #end
    #
    #PeriodicTable::Element.all[first..last].each.with_index(index) do |element, i| 
    #  puts "#{i}. #{element.name}".colorize(:yellow)
    #  sleep 0.25
    #end
    #sleep 0.5
  end
  
  def display_all_elements(element_list) 
    element_list.each.with_index(1) do |element, i| 
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.25
    end
    sleep 1
  end
  
  def display_all_elements_v2(element_list, first_element_index)
    element_list.each_with_index(first_element_index) do |element, i|
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.25
    end
    puts "Every element has been displayed."
    sleep 1
  end

  def examine_element
    input = nil 
    
    until input == "Back"
      puts "\nWhich element would you like to examine?".colorize(:light_blue)
      puts "Please enter its name here, or type 'back' to go back to the Main Menu:\n".colorize(:light_blue)
      input = gets.strip.capitalize 
      element = PeriodicTable::Element.find_element_by_name(input)
      
      if !element.nil?
        list_properties_of(element)
      elsif input == "Back"
        puts "\nOK. Back to the Main Menu we go!".colorize(:light_blue)
      else 
        puts "\nI'm sorry. I do not recognize that element.".colorize(:light_blue) 
        puts "Please be careful to spell its name correctly.".colorize(:light_blue)
      end
    end
  end

  def list_properties_of(element)
    property_collection = make_property_collection_from(element)
    
    puts "\n---------------------------------------------------------------------------"
    puts "Element: #{element.name}\n".colorize(:light_red)
    
    property_collection.each {|property_hash| display_property_from(property_hash)}
    
    puts "\nURL: #{element.element_url}".colorize(:light_green)
    puts "---------------------------------------------------------------------------"
    sleep 1
  end
  
  def make_property_collection_from(element)
    [
      {"Atomic Number" => element.atomic_number, "color" => :light_yellow},
      {"Symbol" => element.symbol, "color" => :light_green},
      {"Atomic Weight" => element.atomic_weight, "color" => :light_cyan},
      {"Origin of Name" => element.name_origin, "color" => :light_blue},
      {"Element Type" => element.element_type, "color" => :light_magenta},
      {"Group" => element.group, "color" => :light_red},
      {"Period" => element.period, "color" => :light_yellow},
      {"Density" => element.density, "units" => "g/cm^3", "color" => :light_green},
      {"Melting Point" => element.melting_point, "units" => "K", "color" => :light_cyan},
      {"Boiling Point" => element.boiling_point, "units" => "K", "color" => :light_blue},
      {"Heat Capacity" => element.heat_capacity, "units" => "J/(g * K)", "color" => :light_magenta},
      {"Electronegativity (Pauline Scale)" => element.electronegativity, "color" =>  :light_red}, 
      {"Abundance in Earth's Crust" => element.abundance, "units" => "mg/kg", "color" => :light_yellow}
    ]
  end
  
  def display_property_from(property_hash)
    key = property_hash.keys.first # "Atomic Number", "Symbol", "Period", etc.
    value = property_hash.values.first # element.atomic_number, element.symbol, etc.
    units = property_hash["units"] # nil, "g/cm^3", "K", etc.
    
    unless value.nil? || value == "0"
      puts "#{key}: #{value} #{units}".strip.colorize(property_hash["color"])
      sleep 0.5
    end
  end
  
  def list_elements_alphabetically 
    puts "\n"
    sorted_elements = PeriodicTable::Element.all.sort_by{|element| element.name}
    display_all_elements(sorted_elements)
  end
end
