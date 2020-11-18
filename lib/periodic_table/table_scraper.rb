class PeriodicTable::TableScraper
  def self.scrape_periodic_table
    page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/List_of_chemical_elements"))
    scraped_elements = page.css("#mw-content-text table.wikitable tbody tr")[4..-2]
    zero_abundance_footnote = page.css("#cite_note-fn14-18 span.reference-text").text
    
    elements_array = scraped_elements.collect do |scraped_element| 
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
    
    # These two variable definitions are necessary in order to set up the special case for Livermorium:
    symbol_text = element_properties_node[1].text
    name_text = element_properties_node[2].text
    
    # This is that special case for Livermorium:
    if symbol_text == "Lv"
      name_text = get_text_from(element_properties_node[2])
    end
    
    # Make and return the element_properties_hash:
    element_properties_hash = {
      atomic_number: element_properties_node[0].text,
      symbol: symbol_text,
      element_type: determine_element_type_from(background_color),
      name: name_text,
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
    # It also prevents citation references like [III][IV] from showing up in the values.
    
    span_node = element_property_node.css("span")
    
    if span_node.size == 0
      element_property_node.children[0].text.strip
    else
      span_node.children[0].text.strip
    end
  end

  # The following helper methods deal with modifying values to make them more readable:
  
  def self.number_or_na(node_text)
    # Change the value of the node_text to nil unless it's a number.
    # This affects property nodes that have blank or "-" values.
    
    node_text.match(/\d+/) ? node_text : "N/A"
  end
  
  def self.remove_brackets_or_uncertainty_from(attribute_value)
    if attribute_value.match(/\[\d+\]/) 
      attribute_value.gsub(/(\[|\])/, "") # Remove brackets (if any) from the attribute_value
    else
      attribute_value.to_f # Remove uncertainty (if any) from the attribute_value
    end
  end
  
  def self.remove_parentheses_from(attribute_value)
    attribute_value.gsub(/(\(|\))/, "")
  end
  
  def self.insert_zero_abundance_footnote(elements_array, zero_abundance_footnote)
    # Insert the zero_abundance_footnote here for abundance values equal to zero:
    
    elements_array.each do |element_attributes_hash|
      if element_attributes_hash[:abundance] == "0"
        element_attributes_hash[:abundance] += " (#{zero_abundance_footnote})"
      end
    end
    
    elements_array
  end
end
