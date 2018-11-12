module PeriodicTable::ValueModifier
  # Note: these should all be used as instance methods in the Scraper only.
  # My goal with all of these is to make the property values look like numbers.
  
  def number_or_na(node_text)
    # Change the value of the node_text to nil unless it's a number.
    # This affects property nodes that have blank or "-" values.
    
    node_text.match(/\d+/) ? node_text : "N/A"
  end
  
  def remove_brackets_or_uncertainty_from(value)
    if value.match(/\[\d+\]/) 
      value.gsub(/(\[|\])/, "") # Remove brackets (if any) from the value
    else
      value.to_f # Remove uncertainty (if any) from the value
    end
  end
  
  def remove_parentheses_from(value)
    value.gsub(/(\(|\))/, "")
  end
end