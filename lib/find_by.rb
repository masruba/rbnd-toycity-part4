class Module
  def create_finder_methods(*attributes)
		attributes.each do |attribute|
		  class_eval("def self.find_by_#{attribute}(value); products = all; products.select{|product| product.#{attribute} == value}.first ; end")
		end
	end
end
