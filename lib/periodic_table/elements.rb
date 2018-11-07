class PeriodicTable::Element
  attr_accessor :atomic_number, :symbol, :element_type, :name, :element_url, :name_origin, :group, :period, :atomic_weight, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance

  @@all = []

  def self.new_from_periodic_table(element_attributes = {}) 
    self.new.tap do |element| 
      element_attributes.each{|key, value| element.send("#{key}=", value)}
      
      @@all << element
    end
  end

   def self.all
    @@all
  end
  
  def self.find_element_by_name(name)
    self.all.detect {|element| element.name == name}
  end
  
  def self.find_element_by_atomic_number(number)
    binding.pry
    self.all.detect {|element| element.atomic_number == number}
  end
end