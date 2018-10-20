class PeriodicTable::TableScraper

  def scrape_and_create_elements
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)
    scraped_elements.delete(scraped_elements.last) #Remove the last node, which contains notes and no chemical elements.
    elements_with_properties = scraped_elements.collect {|element| self.get_properties_of(element)}
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

    binding.pry

  end
end

PeriodicTable::TableScraper.new.scrape_and_create_elements
