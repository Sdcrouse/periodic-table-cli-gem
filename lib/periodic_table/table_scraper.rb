class PeriodicTable::TableScraper
  extend PeriodicTable::ValueModifier

  def self.scrape_periodic_table
    page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_chemical_elements"))
    scraped_elements = page.css("#mw-content-text table.wikitable tbody tr")
    
    # Note: scraped_elements has three extra nodes that it doesn't need.
    # This is accounted for in the code below:
    scraped_elements[2..-2].collect do |scraped_element| 
      make_properties_hash_from(scraped_element)
    end
  end

  def self.make_properties_hash_from(scraped_element)
    # The following four variables help to spread out the code and make the element_properties_hash more readable:
    
    element_properties = scraped_element.css("td")
    background_color = element_properties[1].attr("style").gsub("background:", "")
    atomic_weight_node = find_value_in(element_properties[6])
    melting_point = find_value_in(element_properties[8])
    
    element_properties_hash = {
      atomic_number: element_properties[0].text.to_i,
      symbol: element_properties[1].text,
      element_type: determine_element_type_from(background_color),
      name: element_properties[2].text,
      element_url: "https://en.wikipedia.org" + element_properties[2].css("a").attr("href").value,
      name_origin: element_properties[3].text,
      group: number_or_nil(element_properties[4].text),
      period: element_properties[5].text,
      atomic_weight: remove_brackets_or_uncertainty_from(atomic_weight_node.text),
      density: remove_parentheses_from(element_properties[7].children[0].text),
      melting_point: modify_value_of(melting_point),
      boiling_point: modify_value_of(element_properties[9].children[0]),
      heat_capacity: number_or_nil(element_properties[10].text),
      electronegativity: number_or_nil(element_properties[11].text),
      abundance: element_properties[12].children[0].text.strip 
    }
  end
  
  #-----------------------------Helper Methods-----------------------------------------
  
  def self.determine_element_type_from(background_color)
    case background_color
    when "#f0ff8f"
      "Reactive nonmetal"
    when "#c0ffff"
      "Noble gas"
    when "#ff6666"
      "Alkali metal"
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
  end
  
  def self.find_value_in(node) 
    # This method should receive a node from the element_properties Array as its argument.
    # This helps the scraper get the needed text nodes from inconsistently structured td nodes.
    
    span_node = node.css("span")
    
    if span_node.size == 0
      node.children[0]
    else
      span_node.children[0]
    end
  end
end
