class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
		attributes.each do |attribute|
		  class_eval("def self.find_by_(#{attribute}, attr_value); products = all; products.find{|product| product.#{attribute} == attr_value} ; end")
		end
	end
end
