class PeriodicTable::Element
  attr_accessor :atomic_number, :symbol, :element_type, :name, :element_url, :name_origin, :group, :period, :atomic_weight, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance

  @@all = []

  def self.new_from_periodic_table(element_attributes_hash = {}) 
    self.new.tap do |element| 
      element_attributes_hash.each{|key, value| element.send("#{key}=", value)}
      
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
    self.all.detect {|element| element.atomic_number == number.to_s}
  end
  
  def self.select_elements_by_atomic_number(first_number, last_number)
    # This assumes that self.all is currently sorted by atomic_number
    # It also assumes that it will have to convert first_number and last_number to index numbers.
    
    self.all[first_number - 1..last_number - 1]
  end
end