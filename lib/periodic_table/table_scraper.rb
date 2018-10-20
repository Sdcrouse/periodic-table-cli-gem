class PeriodicTable::TableScraper

  def scrape_and_create_elements
    page = self.get_page("https://en.wikipedia.org/wiki/List_of_chemical_elements")
    scraped_elements = self.scrape_elements_from(page)
    binding.pry
    #self.make_elements_from(scraped_elements)
  end

  def get_page(page)
    Nokogiri::HTML(open(page))
  end

  def scrape_elements_from(page)
    page.css("#mw-content-text table.wikitable tbody tr").select{|element| element.attribute("class") == nil}
  end

  def make_elements_from(scraped_elements)
    puts "I made the elements!"
  end

end

PeriodicTable::TableScraper.new.scrape_and_create_elements
