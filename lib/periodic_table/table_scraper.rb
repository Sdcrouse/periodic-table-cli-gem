class PeriodicTable::TableScraper

  def scrape_and_create_elements
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)

    2.times do
      scraped_elements.delete(scraped_elements.first)
      # Somehow, Nokogiri included the tr nodes from thead!
    end
    scraped_elements.delete(scraped_elements.last) # Remove the last node, which contains notes and no chemical elements.
    #binding.pry
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
    element_properties_hash = {}
    element_properties = scraped_element.css("td")
    binding.pry
    # Atomic Number: element_properties[0].text
    # Symbol: element_properties[1].text
    # background_color = element_properties[1].attr("style").gsub("background:", "")
    # Element Type: #change this attribute name in the other files
      #"Reactive nonmetal" if background_color == "#f0ff8f"
      #"Noble gas" if background_color == "#c0ffff"
      #"Alkaline earth metal" if background_color == "#ffdead"
      #"Metalloid" if background_color == "#cccc99"
      #"Post-transition metal" if background_color == "#cccccc"
      #"Transition metal" if background_color == "#ffc0c0"
      #"Lanthanide" if background_color == "#ffbfff"
      #"Actinide" if background_color == "#ff99cc"
      #"Unknown chemical properties" if background_color == "#e8e8e8"
    # Name: element_properties[2].text
    # Element URL: "https://en.wikipedia.org" + element_properties[2].css("a").attr("href").value
    # Origin of Name: element_properties[3].text #capitalize this sentence
    # Group: element_properties[4].text #n/a or nil if that returns "" --> check this!
    # Period: element_properties[5].text
    
    # Atomic Weight (with parentheses; requires explanation): element_properties[6].css("span").text
    
    # Put the next set of code in a separate method.
    # Use separate #gsub statements below! Use a case statement.
    # atomic_weight = element_properties[6].css("span").text
    # case atomic_weight
    # when /\[\d+\]/ # Remove brackets (if any) from the atomic weight
        #atomic_weight = atomic_weight.gsub(/(\[|\])/, "")
    # else # Remove parentheses (if any) from the atomic weight) 
        #atomic_weight = atomic_weight.to_f
    # end
    # Atomic Weight (without parentheses): element_properties[6].css("span").text
    # Atomic Weight (without brackets): element_properties[6].css("span").text.gsub(/(\[|\])/, "")
    
    # Density: element_properties[7].text.gsub(/(\(|\))/, "")
    # Melting Point: element_properties[8].css("span").text (Note: some of these nodes return "-", so be sure to account for that.)
    # Boiling Point: element_properties[9].text (See note for Melting Point)
    # Heat Capacity: element_properties[10].text (See note for Melting Point)
    # Electronegativity: element_properties[11].text (See note for Melting Point)
    # Abundance in earth's crust: element_properties[12].text.strip #The scientific notation looks a bit strange; if there're too many properties, discard this one.
  end
end

PeriodicTable::TableScraper.new.scrape_and_create_elements
