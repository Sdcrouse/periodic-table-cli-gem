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
    self.all.detect {|element| element.atomic_number == number}
  end
  
  def self.select_elements_by_atomic_number(first, last)
    # This assumes that self.all is currently sorted by atomic_number
    # It also assumes that it will have to convert first and last to index numbers.
    # This ought to be refactored to adhere to the Single Responsibility Principle.
    
    self.all[first - 1..last - 1]
  end
end