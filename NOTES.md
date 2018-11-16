Rspec test ideas -------------------------------------------------------------------------

Put this in an rspec test for the PeriodicTable::TableScraper's #determine_element_type_from method:

background_color = "Invalid color"
background_color = element_properties[1].attr("style").gsub("background:", "")
Write code that expects self.determine_element_type_from(background_color) to equal "Error. Cannot determine the element type from the background color."

Ideas for modifying code -----------------------------------------------------------------

Put this into the PeriodicTable::TableScraper's #make_properties_hash_from method, but ONLY if you want to explain measurement uncertainty and element stability to the user: 

element_properties_hash[:atomic_weight] = self.find_value_in(element_properties[6])

If you do this, you will also need to delete the method #remove_brackets_or_uncertainty_from.

Note about the TableScraper's method #make_properties_hash_from: Some of the abundance values have scientific notation, which looks a bit strange; if there are too many element properties, discard the abundance property.

In the TableScraper's #scrape_elements_from method, I originally had this line of code appended to part of what is currently in there: ".select{|element| element.attribute("class") == nil}". It doesn't appear to be necessary, but it may help down the road if Wikipedia's HTML ever changes.

In the CLI class, maybe split #list_properties_of into #basic_properties and #more_properties...

The text colors are best seen against a black background. It may be a good idea to use the Colorize gem to make the background of the text black, so that it displays the same on multiple local environments.

I could use the 'break' keyword to get out of loops.

Ideas for more features ------------------------------------------------------------------

•	Be able to return to the Main Menu from ANYWHERE in the program.
•	List all of the chemical elements AND their properties. (Warn the user first!)
•	Let the user choose between listing some chemical elements either with or without their properties.
•	List each element category, group, period, atomic number, etc.
•	Sort the elements by group, period, atomic_number (the default way to show them), etc.
•	Sort the partial lists of elements as well as the list of all elements.
•	Add more help/description options as the program gains new features.
•	Have the option to choose an element and navigate to the next or previous element.
•	When viewing small groups of elements instead of all of them at once, be able to navigate to the first, previous, or next 10 elements or the last 8 elements. Refactor the CLI's #list_elements method and/or add a new method to do that. #element_book method?
•	Maybe add a Glossary option.
•	Use the Colorize gem to distinguish elements by element_type (alkali, noble gas, etc).
•	Add a "List" option that will allow the user to see the list of elements again. (Update: given the new layout of the Main Menu, this option is already there in a different form.)
•	Scrape more information from each Element's URL attribute.
•	Give the user the option to navigate to an Element's webpage through its URL.
•	Calculate average values for Element attributes (melting point, name length, electronegativity, etc).
•	Let the user examine an element by specifying its name OR atomic number.

Ideas for a new version of the CLI ------------------------------------------------------

•	Let the user create an atom/element by specifying the number of protons
•	Return an error message if they specify too many or too few protons
•	Tell the user the name and properties of the atom/element
•	Get more information about the elements by using the PeriodicTableCLI
•	Store each atom that the user creates in an array/inventory
•	Display the names of the atoms in the inventory and the number of each one
•	Display more information about a specific atom in the inventory
•	Erase the inventory at the user’s request

Ideas for a newer version after THAT -----------------------------------------------------

•	Let the user create molecular compounds by specifying the type(s) of atom(s) to use and how many of each type of atom to use
    o	It will also create molecular compounds by adding atoms to molecules
•	Return an error message if the program doesn’t yet recognize that molecular compound
•	Display the name, chemical formula, and other information about that molecular compound
•	Store each compound that the user creates in an array/inventory
•	Display the names of the compounds in the inventory and the number of each one
•	Display more information about a specific molecular compound in the inventory
•	Erase the inventory at the user’s request
•	Be named ChemLabCLI or ChemLabAPI
