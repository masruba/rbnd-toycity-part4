class Module
  def create_count_by_methods(*attributes)
  	#  return a hash with inventory counts, organized by attribute
		attributes.each do |attribute|			
			# http://stackoverflow.com/questions/9480852/array-to-hash-words-count
		  class_eval("def self.count_by_#{attribute}(products); hash_count = Hash.new(0); products.each{|product| hash_count[product.#{attribute}] += 1}; hash_count;end")
		end
	end
end


module Analyzable
	create_count_by_methods("brand", "name") 	

	# average_price should accept an array of Product objects and return the average price. 
 	def average_price(products)
 		price_array = products.map { |product| product.price.to_f}
 		avg = price_array.reduce(:+) / price_array.size.to_f
 		avg.round(2)
 	end

 	def print_hash(hash)
 		str = ""
		hash.each do |key, count|
			str << "\t- " + key + ": " + count.to_s + "\n"
		end
		str
 	end
	# print_report should accept an array of Product objects and 
	# return a summary inventory report containing: average price, counts by brand, and counts by product name.
 	def print_report(products)
 		report_string = ""
 		report_string << "Average Price: " + average_price(products).to_s + "$\n"
		report_string << "Inventory by Brand:\n"
		brands_hash = count_by_brand(products)
		report_string << print_hash(brands_hash)
		report_string << "Inventory by Name:\n"
		names_hash = count_by_name(products) 	
		report_string << print_hash(names_hash)
		report_string
	end  
end
