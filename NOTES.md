Alternate code for the #element_type_from method in PeriodicTable::TableScraper class:

case background_color
when "#f0ff8f"
  "Reactive nonmetal"
when "#c0ffff"
  "Noble gas"
when "#ffdead"
  "Alkaline earth metal"
when "#cccc99"
  "Metalloid"
when "#cccccc"
  "Post-transition metal"
when "#ffc0c0"
  "Transition metal"
when "#ffbfff"
  "Lanthanide"
when "#ff99cc"
  "Actinide"
when "#e8e8e8"
  "Unknown chemical properties"
else 
  "Error. Cannot determine the element type from the background color."
end

Later on, put this in an rspec test for the PeriodicTable::TableScraper's #element_type_from method:
background_color = "Invalid color"
background_color = element_properties[1].attr("style").gsub("background:", "")
Write code that expects background_color to equal "Error. Cannot determine the element type from the background color."