Later on, put this in an rspec test for the PeriodicTable::TableScraper's #determine_element_type_from method:
background_color = "Invalid color"
background_color = element_properties[1].attr("style").gsub("background:", "")
Write code that expects self.determine_element_type_from(background_color) to equal "Error. Cannot determine the element type from the background color."

Put this into the PeriodicTable::TableScraper's #make_properties_hash_from method, but ONLY if you want to explain measurement uncertainty and element stability to the user: 

element_properties_hash[:atomic_weight] = self.find_value_in(element_properties[6])

If you do this, you will also need to delete the method #remove_brackets_or_uncertainty_from.