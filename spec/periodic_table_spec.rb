RSpec.describe PeriodicTable do
  it "has a version number" do
    expect(PeriodicTable::VERSION).not_to be nil
  end

  it "scrapes the periodic table and makes an array of chemical elements" do
    elements_array = PeriodicTable::TableScraper.new.scrape_periodic_table
    
    expect(PeriodicTable::CLI.new.make_elements).to eq(elements_array)
  end
end
