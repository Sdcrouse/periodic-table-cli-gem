RSpec.describe PeriodicTable do
  it "has a version number" do
    expect(PeriodicTable::VERSION).not_to be nil
  end

  it "scrapes the periodic table and creates new Elements" do
    elements_array = PeriodicTable::TableScraper.new.scrape_periodic_table
    
    expect(PeriodicTable::CLI.new.make_elements).to eq(elements_array)
    expect(PeriodicTable::Element.all.size).to eq(118)
  end
end
