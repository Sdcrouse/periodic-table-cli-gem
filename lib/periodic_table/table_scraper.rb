class PeriodicTable::TableScraper

  def scrape_and_create_elements
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)

    2.times do
      scraped_elements.delete(scraped_elements.first)
      # Somehow, Nokogiri included the tr nodes from thead!
    end
    scraped_elements.delete(scraped_elements.last) # Remove the last node, which contains notes and no chemical elements.

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
    # Atomic Number: element_properties[0].text.to_i
    # Symbol: element_properties[1].text
    # background_color = element_properties[1].attr("style").gsub("background:", "")
    # Element Category:
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
    # Element URL: 
    # Origin of Name: element_properties[3].text
    # Atomic Weight (with parentheses; requires explanation): element_properties[6].css("span").text.to_i
    # Atomic Weight (without parentheses):
  end
end

PeriodicTable::TableScraper.new.scrape_and_create_elements
