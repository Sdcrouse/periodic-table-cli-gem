class PeriodicTable::Element
  attr_accessor :atomic_number, :symbol, :element_type, :name, :element_url, :name_origin, :group, :period, :atomic_weight, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance

  @@all = []

  def initialize
    @@all << self
  end

  def self.new_from_periodic_table(element_attributes = {}) 
    # Create a new Element from the scraped periodic table.
    
    self.new.tap do |element| 
      element_attributes.each{|key, value| element.send("#{key}=", value)}
    end
  end

   def self.all
    @@all
  end

  def self.reset_all
    self.all.clear
  end
end
