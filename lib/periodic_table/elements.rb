class PeriodicTable::Element 
  attr_accessor :name, :symbol, :atomic_number, :atomic_weight, :name_origin, :group, :period, :density, :melting_point, :boiling_point, :heat_capacity, :electronegativity, :abundance 
  
  @@all = [] 
  
  def initialize 
    @@all << self 
  end 
  
  def self.new_from_table(table)
    
  end
  
   def self.all 
    @@all 
  end
end