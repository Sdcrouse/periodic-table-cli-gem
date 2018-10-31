class PeriodicTable::CLI
  def call
    make_elements
    start
    puts "\nUntil next time, future chemist!".colorize(:light_cyan)
  end

  def make_elements
    elements_array = PeriodicTable::TableScraper.new.scrape_periodic_table
    
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
    menu_options = ["List Elements", "Examine an Element", "Sort Elements", "Help", "Quit"]
    yes_or_no = "no"
    user_choice = nil
    
    puts "\nHere's where the REAL fun begins!".colorize(:light_yellow)

    until yes_or_no == "y" || yes_or_no == "yes"
      puts "\nWelcome to the Main Menu! What would you like to do?".colorize(:light_yellow)
      user_choice = self.choose_from(menu_options)

      case user_choice
      when 1
        list_elements
      when 2
        examine_element
      when 3 
        sort_elements
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
      sleep 0.5 
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
    puts "\nIn this program, you are able to view a list of all or some of the chemical elements, examine an individual chemical element for more information, and sort the elements.".colorize(:light_red)
    sleep 5
    puts "\nBy default, the chemical elements are listed by their atomic numbers. The 'Sort Elements' option will sort them by their names.".colorize(:light_red)
    sleep 5
  end

  def describe_main_menu_options
    puts "\nHere are the Main Menu options:".colorize(:light_yellow)
    sleep 1
    puts "Press 1 to view a list of chemical elements from the Periodic Table.".colorize(:light_yellow)
    sleep 1
    puts "Press 2 to get more information about an element (name, properties, etc).".colorize(:light_yellow)
    sleep 1
    puts "Press 3 to see the chemical elements sorted by name.".colorize(:light_yellow)
    sleep 1
    puts "Press 4 to view this description of the Main Menu options.".colorize(:light_yellow)
    sleep 1
    puts "Press 5 to quit the Interactive Periodic Table.".colorize(:light_yellow)
    sleep 3
  end

  def list_elements
    options = ["Elements 1-10", "Elements 11-20", "Elements 21-30", "Elements 31-40", "Elements 41-50", "Elements 51-60", "Elements 61-70", "Elements 71-80", "Elements 81-90", "Elements 91-100", "Elements 101-110", "Elements 111-118", "All of them!", "Back to Main Menu"]
    user_choice = nil
    
    until user_choice == 14
      puts "\nWhich elements would you like to see?".colorize(:light_magenta)
      user_choice = choose_from(options)
      puts "\n"
      
      if user_choice.between?(1,12)
        display_set_of_ten_elements(user_choice)
      elsif user_choice == 13 
        display_all_elements(PeriodicTable::Element.all)
      elsif user_choice == 14 
        puts "OK. Heading back to the Main Menu now.".colorize(:light_magenta)
      else
        puts "I don't understand. Please try again.".colorize(:light_magenta)
      end
    end
  end
  
  def display_set_of_ten_elements(set_number) 
    # Example: if set_number == 2, then do this to puts Elements 11-19:
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
      puts "#{i}. #{element.name}".colorize(:yellow)
      sleep 0.5
    end
  end
  
  def display_all_elements(element_list) 
    element_list.each.with_index(1) do |element, i| 
      puts "#{i}. #{element.name}".colorize(:light_cyan)
      sleep 0.5
    end
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
    puts "\n---------------------------------------------------------------------------"
    puts "Element: #{element.name}\n".colorize(:light_red)
    sleep 1
    
    puts "Atomic Number: #{element.atomic_number}".colorize(:light_yellow)
    sleep 1
    
    puts "Symbol: #{element.symbol}".colorize(:light_green)
    sleep 1
    
    puts "Atomic Weight: #{element.atomic_weight}".colorize(:light_cyan)
    sleep 1
    
    puts "Origin of Name: #{element.name_origin}".colorize(:light_blue)
    sleep 1
    
    puts "Element Type: #{element.element_type}".colorize(:light_magenta)
    sleep 1
    
    puts "Group: #{element.group}".colorize(:light_red) unless element.group.nil?
    sleep 1 unless element.group.nil?
    
    puts "Period: #{element.period}".colorize(:light_yellow)
    sleep 1
    
    puts "Density: #{element.density} g/cm^3".colorize(:light_green)
    sleep 1
    
    puts "Melting Point: #{element.melting_point} K".colorize(:light_cyan) unless element.melting_point.nil?
    sleep 1 unless element.melting_point.nil?
    
    puts "Boiling Point: #{element.boiling_point} K".colorize(:light_blue) unless element.boiling_point.nil?
    sleep 1 unless element.boiling_point.nil?
    
    puts "Heat Capacity: #{element.heat_capacity} J/(g * K)".colorize(:light_magenta) unless element.heat_capacity.nil?
    sleep 1 unless element.heat_capacity.nil?
    
    puts "Electronegativity (Pauline Scale): #{element.electronegativity}".colorize(:light_red) unless element.electronegativity.nil?
    sleep 1 unless element.electronegativity.nil?
    
    puts "Abundance in Earth's Crust: #{element.abundance} mg/kg".colorize(:light_yellow) unless element.abundance == "0"
    sleep 1 unless element.abundance == "0"
    
    puts "\nURL: #{element.element_url}".colorize(:light_green)
    puts "---------------------------------------------------------------------------"
    sleep 1
  end
  
  def list_elements_v2(element)
    property_collection = [
      {"Element" => "#{element.name}\n", "color" => :light_red},
      {"Atomic Number" => "#{element.atomic_number}", "color" => :light_yellow},
      {"Symbol" => "#{element.symbol}", "color" => :light_green},
      {"Atomic Weight" => "#{element.atomic_weight}", "color" => :light_cyan},
      {"Origin of Name" => "#{element.name_origin}", "color" => :light_blue},
      {"Element Type" => "#{element.element_type}", "color" => :light_magenta},
      {"Group" => "#{element.group}", "color" => :light_red},
      {"Period" => "#{element.period}", "color" => :light_yellow},
      {"Density" => "#{element.density} g/cm^3", "color" => :light_green},
      {"Melting Point" => "#{element.melting_point} K", "color" => :light_cyan},
      {"Boiling Point" => "#{element.boiling_point} K", "color" => :light_blue},
      {"Heat Capacity" => "#{element.heat_capacity} J/(g * K)", "color" => :light_magenta},
      {"Electronegativity (Pauline Scale)" => "#{element.electronegativity}", "color" =>  (:light_red}, 
      {"Abundance in Earth's Crust" => "#{element.abundance} mg/kg", "color" => :light_yellow},
      {"\nURL" => "#{element.element_url}", "color" => :light_green)}
    ]
  end
  
  def sort_elements 
    puts "\n"
    sorted_elements = PeriodicTable::Element.all.sort_by{|element| element.name}
    display_all_elements(sorted_elements)
  end
end
