Later on, put this in an rspec test for the PeriodicTable::TableScraper's #element_type_from method:
background_color = "Invalid color"
background_color = element_properties[1].attr("style").gsub("background:", "")
Write code that expects background_color to equal "Error. Cannot determine the element type from the background color."