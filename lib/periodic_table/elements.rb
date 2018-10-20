class PeriodicTable::Element
  attr_accessor :name, :name_origin, :symbol, :atomic_number, :atomic_weight, :group, :period, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance, :element_url

  @@all = []

  def initialize(attributes_hash)
    attributes_hash.each{|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.new_from_periodic_table(table = {}) # Create a new Element from the scraped periodic table.
    # Note: unless I want to explain uncertainty, I may need to gsub the @atomic_weight values' parentheses with ""
    attributes = {
      name: "Hydrogen",
      symbol: "H",
      atomic_number: 1,
      atomic_weight: 1.008,
      element_url: "https://en.wikipedia.org/wiki/Hydrogen",
      name_origin: "composed of the Greek elements hydro- and -gen meaning 'water-forming'",
      group: 1,
      period: 1,
      density: 0.00008988,
      melting_point: 14.01,
      boiling_point: 20.28,
      heat_capacity: 14.304,
      electronegativity: 2.20,
      abundance: 1400
    }
    self.new(attributes)
  end

   def self.all
    @@all
  end

  def self.reset_all
    self.all.clear
  end
end
