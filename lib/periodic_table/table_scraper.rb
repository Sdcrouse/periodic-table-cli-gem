class PeriodicTable::TableScraper
  extend PeriodicTable::ValueModifier
  # The following class methods are in the ValueModifier module: #number_or_na, #remove_brackets_or_uncertainty_from, #remove_parentheses_from, and #insert_zero_abundance_footnote

  def self.scrape_periodic_table
    page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_chemical_elements"))
    scraped_elements = page.css("#mw-content-text table.wikitable tbody tr")
    zero_abundance_footnote = scraped_elements.search("#cite_note-fn14-18 span.reference-text").text
    
    # Note: scraped_elements has three extra nodes that it doesn't need.
    # This is accounted for in the code below:
    elements_array = scraped_elements[2..-2].collect do |scraped_element| 
      make_properties_hash_from(scraped_element)
    end
    
    # Return the elements_array after adding the zero_abundance_footnote to the appropriate hashes:
    insert_zero_abundance_footnote(elements_array, zero_abundance_footnote)
  end

  def self.make_properties_hash_from(scraped_element)
    # Get the element_properties_node
    element_properties_node = scraped_element.css("td")
    
    # The following five variables help to spread out the code and make the element_properties_hash more readable:
    background_color = element_properties_node[1].attr("style").gsub("background:", "")
    atomic_weight_text = get_text_from(element_properties_node[6])
    density_text = get_text_from(element_properties_node[7])
    melting_point_text = get_text_from(element_properties_node[8])
    boiling_point_text = get_text_from(element_properties_node[9])
    
    # Make and return the element_properties_hash:
    element_properties_hash = {
      atomic_number: element_properties_node[0].text,
      symbol: element_properties_node[1].text,
      element_type: determine_element_type_from(background_color),
      name: element_properties_node[2].text,
      element_url: "https://en.wikipedia.org" + element_properties_node[2].css("a").attr("href").value,
      name_origin: element_properties_node[3].text,
      group: number_or_na(element_properties_node[4].text),
      period: element_properties_node[5].text,
      atomic_weight: remove_brackets_or_uncertainty_from(atomic_weight_text),
      density: remove_parentheses_from(density_text),
      melting_point: remove_parentheses_from(number_or_na(melting_point_text)),
      boiling_point: remove_parentheses_from(number_or_na(boiling_point_text)),
      heat_capacity: number_or_na(element_properties_node[10].text),
      electronegativity: number_or_na(element_properties_node[11].text),
      abundance: element_properties_node[12].children[0].text.strip 
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
  
  def self.get_text_from(element_property_node) 
    # This method should receive a node from the element_properties Array (from the class method #make_properties_hash_from) as its argument.
    # This helps the scraper get the needed text from inconsistently structured td nodes.
    
    span_node = element_property_node.css("span")
    
    if span_node.size == 0
      element_property_node.children[0].text.strip
    else
      span_node.children[0].text.strip
    end
  end
end
