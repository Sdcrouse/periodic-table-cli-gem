class PeriodicTable::CLI
  attr_reader :elements

  def initialize # Remember to update this with a list of Elements (or delete it)
    @elements = ["helium", "carbon", "oxygen", "nitrogen", "sulfur", "astatine", "phosphorus", "neon", "xenon", "iron", "lead", "silver", "gold", "sodium"]
  end

  def call
    # Delete the following line once I make the Scraper:
    PeriodicTable::Element.new_from_table
    start
    puts "\nUntil next time, future chemist!"
  end

  def start
    puts "Welcome to the Interactive Periodic Table!"
    puts "Ready to start learning some chemistry? (Y/n)"
    start_program = gets.strip.downcase

    main_menu unless start_program == "n" || start_program == "no"
  end

  def main_menu # Refactor the program so that most of it is run from here, including the options to examine an element and sort elements.
    menu_options = ["List Elements", "Help", "Quit"]
    yes_or_no = "no"
    user_choice = nil

    #call PeriodicTable::Table here. That should then scrape Wikipedia.
    until yes_or_no == "y" || yes_or_no == "yes"
      puts "\nWelcome to the Main Menu! What would you like to do?"
      user_choice = self.choose_from(menu_options)

      case user_choice
      when 1
        list_elements
      when 2
        help
      when 3
        puts "\nAre you sure you want to quit? (N/y):"
        yes_or_no = gets.strip.downcase
      else
        puts "I don't understand. Please try again."
      end
    end
  end

  def choose_from(option_list)
    puts "Choose from the numbered list below:\n\n"
    option_list.each.with_index(1) {|option, i| puts "#{i}. #{option}"}
    gets.strip.to_i
  end

  def help # Note: I slowed these methods down to give the user more time to read.
    introduction
    describe_main_menu_options
  end

  def introduction
    puts "\nThe Interactive Periodic Table is designed to mimic a real periodic table by providing information about each of the currently known chemical elements."
    sleep 5
    puts "\nIn this program, you are able to view a list of all or some of the chemical elements, sort that list by a category of your choice, and examine an individual chemical element for more information."
    sleep 5
    puts "\nPlease note that you are unable to sort the list or view an individual element unless you choose option 1 from the Main Menu."
    sleep 5
  end

  def describe_main_menu_options
    puts "\nHere are the Main Menu options:"
    puts "Press 1 to view a list of chemical elements from the Periodic Table."
    puts "Press 2 to view this description of the Main Menu options."
    puts "Press 3 to quit the Interactive Periodic Table."
    sleep 5
  end

  def list_elements
    user_choice = nil
    list_choices = [
      "List elements without their properties",
      "List elements with their properties",
      "List element periods",
      "List element groups",
      "List element categories",
      "Help",
      "Return to Main Menu"
    ]

    puts "\nHere's where the REAL fun begins!"
    until user_choice == 7
      puts "How do you want to list the elements?"
      user_choice = self.choose_from(list_choices)
      puts "\n"

      case user_choice
      when 1
        list_elements_without_properties
      when 2
        list_elements_with_properties
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
    options = ["Elements 1-5", "Elements 6-10", "Elements 11-15", "All Elements", "Go Back"]
    user_choice = nil

    until user_choice == 5
      puts "Which elements would you like to see?"
      user_choice = choose_from(options)
      puts "\n"

      case user_choice
      # Refactor part of this into a method that works like a book (i.e. includes the choices First, Previous, Next, and Last)
      # Also, displaying ten elements instead of five is doable.
      # Be sure to puts "\n" after displaying them.
      when 1
        # Delete and refactor this stuff after I make the scraper
        self.elements.unshift(PeriodicTable::Element.all[0].name)
        self.elements[0..4].each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 2
        self.elements[5..9].each.with_index(6) {|element, i| puts "#{i}. #{element}"}
      when 3
        self.elements[10..14].each.with_index(11) {|element, i| puts "#{i}. #{element}"}
      when 4
        self.elements.each.with_index(1) {|element, i| puts "#{i}. #{element}"}
      when 5 # Go back to #list_elements
      else
        puts "I don't understand. Please try again."
      end
      sleep 1
    end
  end

  def list_elements_with_properties
    # Maybe split this into #basic_properties and #more_properties...
    # :name, :symbol, :atomic_number, :atomic_weight, :element_url, :name_origin, :group, :period, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance
    PeriodicTable::Element.all.each.with_index(1) do |element, i|
      puts "--------------------------------------"
      puts "Element #{i}\n\n" # When scraped, each of these should have a value or 'n/a'
      puts "Name: #{element.name}"
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
end
