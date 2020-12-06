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

  it "saves the correct information for an Element" do
    # This test may need to be updated when Wikipedia's Periodic Table is updated.

    PeriodicTable::CLI.new.make_elements

    boron = PeriodicTable::Element.all[4]

    expect(boron.atomic_number).to eq("5")
    expect(boron.symbol).to eq("B")
    expect(boron.name).to eq("Boron")
    expect(boron.element_type).to eq("Metalloid")
    expect(boron.name_origin).to eq("Borax, a mineral (from Arabic bawraq)")
    expect(boron.group).to eq("13")
    expect(boron.period).to eq("2")
    expect(boron.atomic_weight).to eq(10.81)
    expect(boron.melting_point).to eq("2349")
    expect(boron.boiling_point).to eq("4200")
    expect(boron.heat_capacity).to eq("1.026")
    expect(boron.electronegativity).to eq("2.04")
    expect(boron.abundance).to eq("10")
    expect(boron.element_url).to eq("https://en.wikipedia.org/wiki/Boron")
  end
end
