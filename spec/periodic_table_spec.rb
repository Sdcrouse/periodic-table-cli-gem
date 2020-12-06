RSpec.describe PeriodicTable do
  it "has a version number" do
    expect(PeriodicTable::VERSION).not_to be nil
  end

  it "scrapes all of the elements from the periodic table" do
    elements_array = PeriodicTable::TableScraper.scrape_periodic_table
    
    expect(elements_array.size).to eq(118)
  end

  it "creates new Elements from the scraped data" do
    PeriodicTable::CLI.new.make_elements

    expect(PeriodicTable::Element.all.size).to eq(118)
  end
end
