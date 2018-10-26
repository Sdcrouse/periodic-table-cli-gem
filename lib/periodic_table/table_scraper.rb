class PeriodicTable::TableScraper

  def scrape_and_create_elements
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)

    2.times do
      scraped_elements.delete(scraped_elements.first)
      # Somehow, Nokogiri included the tr nodes from thead!
    end
    scraped_elements.delete(scraped_elements.last) # Remove the last node, which contains notes and no chemical elements.
    binding.pry
    self.make_properties_hash_from(scraped_elements[0]) # Delete this line and uncomment the line below.
    #elements_with_properties = scraped_elements.collect {|element| self.make_properties_hash_from(element)}
    #Create new Element instances here!
    #binding.pry
  end

  def get_page(page)
    Nokogiri::HTML(open(page))
  end

  def scrape_elements_from(page)
    page.css("#mw-content-text table.wikitable tbody tr")
    #.select{|element| element.attribute("class") == nil}
  end

  def make_properties_hash_from(scraped_element)
    # Make sure the element_properties_hash matches this: 
    #attributes = {
    #  atomic_number: 1,
    #  symbol: "H",
    #  element_type: "Reactive nonmetal",
    #  name: "Hydrogen",
    #  element_url: "https://en.wikipedia.org/wiki/Hydrogen",
    #  name_origin: "Composed of the Greek elements hydro- and -gen meaning 'water#-forming'",
    #  group: 1,
    #  period: 1,
    #  atomic_weight: 1.008,
    #  density: 0.00008988,
    #  melting_point: 14.01,
    #  boiling_point: 20.28,
    #  heat_capacity: 14.304,
    #  electronegativity: 2.20,
    #  abundance: 1400
    #}
    
    # Attributes:
    #:atomic_number, :symbol, :element_type, :name, :element_url, :name_origin, :group, :period, :atomic_weight, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance
    element_properties_hash = {}
    element_properties = scraped_element.css("td")
    
    element_properties_hash[:atomic_number] = element_properties[0].text
    element_properties_hash[:symbol] = element_properties[1].text
    
    background_color = element_properties[1].attr("style").gsub("background:", "")
    element_properties_hash[:element_type] = self.determine_element_type_from(background_color)
    
    element_properties_hash[:name] = element_properties[2].text
    element_properties_hash[:element_url] = "https://en.wikipedia.org" + element_properties[2].css("a").attr("href").value
    element_properties_hash[:name_origin] = element_properties[3].text
    element_properties_hash[:group] = self.number_or_na(element_properties[4].text)
    element_properties_hash[:period] = element_properties[5].text
    
    atomic_weight_node = self.find_value_in(element_properties[6])
    element_properties_hash[:atomic_weight] = self.remove_brackets_or_uncertainty_from(atomic_weight_node.text)
   
    element_properties_hash[:density] = self.remove_parentheses_from(element_properties[7].children[0].text)
    
    melting_point = self.find_value_in(element_properties[8])
    element_properties_hash[:melting_point] = self.modify_value_of(melting_point)
    
    boiling_point = self.number_or_na(element_properties[9].children[0].text)
    element_properties_hash[:boiling_point] = self.remove_parentheses_from(boiling_point)
    
    element_properties_hash[:heat_capacity] = self.number_or_na(element_properties[10].text)
    element_properties_hash[:electronegativity] = self.number_or_na(element_properties[11].text)
    element_properties_hash[:abundance] = element_properties[12].text.strip 
    #...[12].children[0].text.strip ^^^
    #The scientific notation looks a bit strange; if there're too many properties, discard this one.
    #binding.pry
    element_properties_hash
  end
  
  def determine_element_type_from(background_color)
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
  end
  
  def number_or_na(node_text)
    node_text.match(/\d+/) ? node_text : "N/A"
  end
  
  def remove_brackets_or_uncertainty_from(value)
    if value.match(/\[\d+\]/) # Remove brackets (if any) from the value
      value.gsub(/(\[|\])/, "")
    else # Remove uncertainty (if any) from the value
      value.to_f
    end
  end
  
  def remove_parentheses_from(value)
    value.gsub(/(\(|\))/, "")
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
    property = self.number_or_na(property_node.text.strip)
    self.remove_parentheses_from(property)
  end
end

PeriodicTable::TableScraper.new.scrape_and_create_elements
