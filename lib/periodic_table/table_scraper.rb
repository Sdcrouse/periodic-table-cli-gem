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
    #Why does scraped_element.css("td") keep returning [] ?
    binding.pry

  end
end

PeriodicTable::TableScraper.new.scrape_and_create_elements
