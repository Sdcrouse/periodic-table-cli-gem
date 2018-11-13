module PeriodicTable::ValueModifier
  # Note: these should all be used as class methods in the Scraper only.
  # My goal with most of these is to make some property values look like numbers.
  # The last method adds a footnote to abundance values of zero.
  
  def number_or_na(node_text)
    # Change the value of the node_text to nil unless it's a number.
    # This affects property nodes that have blank or "-" values.
    
    node_text.match(/\d+/) ? node_text : "N/A"
  end
  
  def remove_brackets_or_uncertainty_from(attribute_value)
    if attribute_value.match(/\[\d+\]/) 
      attribute_value.gsub(/(\[|\])/, "") # Remove brackets (if any) from the attribute_value
    else
      attribute_value.to_f # Remove uncertainty (if any) from the attribute_value
    end
  end
  
  def remove_parentheses_from(attribute_value)
    attribute_value.gsub(/(\(|\))/, "")
  end
  
  def insert_zero_abundance_footnote(elements_array, zero_abundance_footnote)
    # Insert the zero_abundance_footnote here for abundance values equal to zero:
    
    elements_array.each do |element_attributes_hash|
      if element_attributes_hash[:abundance] == "0"
        element_attributes_hash[:abundance] += " (#{zero_abundance_footnote})"
      end
    end
    
    elements_array
  end
end