class PeriodicTable::TableScraper

  def scrape_periodic_table
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)
    self.delete_unnecessary_nodes_from(scraped_elements)
    
    scraped_elements.collect do |scraped_element| 
      self.make_properties_hash_from(scraped_element)
    end
  end

  def get_page(page)
    Nokogiri::HTML(open(page))
  end

  def scrape_elements_from(page)
    page.css("#mw-content-text table.wikitable tbody tr")
    #.select{|element| element.attribute("class") == nil}
  end
  
  def delete_unnecessary_nodes_from(elements_array)
    2.times do
      elements_array.delete(elements_array.first)
      # Somehow, Nokogiri included the tr nodes from thead! These need to be deleted.
    end
    elements_array.delete(elements_array.last) # Remove the last node, which contains notes and no chemical elements.
  end

  def make_properties_hash_from(scraped_element)
    element_properties = scraped_element.css("td")
    background_color = element_properties[1].attr("style").gsub("background:", "")
    atomic_weight_node = self.find_value_in(element_properties[6])
    melting_point = self.find_value_in(element_properties[8])
    
    element_properties_hash = {
      atomic_number: element_properties[0].text,
      symbol: element_properties[1].text,
      element_type: self.determine_element_type_from(background_color),
      name: element_properties[2].text,
      element_url: "https://en.wikipedia.org" + element_properties[2].css("a").attr("href").value,
      name_origin: element_properties[3].text,
      group: self.number_or_nil(element_properties[4].text),
      period: element_properties[5].text,
      atomic_weight: self.remove_brackets_or_uncertainty_from(atomic_weight_node.text),
      density: self.remove_parentheses_from(element_properties[7].children[0].text),
      melting_point: self.modify_value_of(melting_point),
      boiling_point: self.modify_value_of(element_properties[9].children[0]),
      heat_capacity: self.number_or_nil(element_properties[10].text),
      electronegativity: self.number_or_nil(element_properties[11].text),
      abundance: element_properties[12].children[0].text.strip 
    }
  end
  
  def determine_element_type_from(background_color)
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
  
  def number_or_nil(node_text)
    node_text.match(/\d+/) ? node_text : nil
  end
  
  def remove_brackets_or_uncertainty_from(value)
    if value.match(/\[\d+\]/) 
      value.gsub(/(\[|\])/, "") # Remove brackets (if any) from the value
    else
      value.to_f # Remove uncertainty (if any) from the value
    end
  end
  
  def remove_parentheses_from(value)
    value.gsub(/(\(|\))/, "") unless value.nil?
  end
  
  def find_value_in(node) # Expect node to equal element_properties[some_number]
    span_node = node.css("span")
    
    if span_node.size == 0
      node.children[0]
    else
      span_node.children[0]
    end
  end
  
  def modify_value_of(property_node)
    property = self.number_or_nil(property_node.text.strip)
    self.remove_parentheses_from(property)
  end
end
