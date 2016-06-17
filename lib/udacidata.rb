require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@file_path_to_csv = File.dirname(__FILE__) + "/../data/data.csv"		
	create_finder_methods("brand", "name") 	

  def self.object_data_exists!(id)
		CSV.foreach(@@file_path_to_csv, headers: true) do |row|
			if row["id"] == id
				return true
			end
		end
		return false
	end

	def self.create(attributes = nil)
		# create the object
		obj = new attributes	
		# If the object's data is not in the database
		if object_data_exists!(obj.id) == false
			# append the data in the database
    	CSV.open(@@file_path_to_csv, "a") do |csv|
      	csv << [obj.id, obj.brand, obj.name, obj.price]
    	end
    end
		# return the object
		return obj
	end 

	# Product.all should return an array of Product objects representing all the data in the database.
  def self.all
		products = []	
		if File.exist?(@@file_path_to_csv) 		
			CSV.read(@@file_path_to_csv, headers:true).each do |row|
		  	products << new(id: row["id"], brand: row["brand"], name: row["product"], price: row["price"])
			end
		end
		#return the array of products.
		products  
	end

 	def self.first(n=1)
 		products = all
 		n == 1? products.first : products.first(n)
 	end


 	def self.last(n=1)
 		products = all
 		n == 1? products.last : products.last(n)
 	end


 	def self.find(id)
		products = all 
		item = products.find{|product| product.id == id}
		raise ProductNotFoundError if item == nil
		item
 	end

 	def self.write_csv(products)
		CSV.open(@@file_path_to_csv, "w") do |csv|
      csv << ["id", "brand", "product", "price"]
			products.each do |product|
      	csv << [product.id, product.brand, product.name, product.price]
  		end  
  	end    
 	end

 	def self.print_products(products)
		products.each do |product|
			print product.id.to_s, " "
			print product.brand.to_s, " "
			print product.name.to_s, " "
			print product.price.to_s, " \n"
		end  
 	end

	# Product.destroy should delete the product corresponding to the given id from the database, 
	# and return a Product object for the product that was deleted.
 	def self.destroy(id)
 		# raise ProductNotFoundError when the product can’t be destroyed because the given ID does not exist 		
		products = all 
 		deleted_item = products.select{|product| product.id == id}.first	
 		raise ProductNotFoundError if deleted_item == nil
		products = products.delete_if{|product| product.id == id}		
		write_csv(products)
		deleted_item
 	end

 	# Product.where should return an array of Product objects that match a given brand or product name.
 	def self.where(product_hash)
 		type = product_hash.keys[0]
 		value = product_hash.values[0]
 		all.select{|product| product.send(type) == value}
 	end 	

	# product_instance.update should change the information for a given Product object, and save the new data to the database.
 	def update(hash_options={})
 		# http://apidock.com/ruby/Object/instance_variable_set
 		hash_options.each do |key, value|
 			variable_name = "@#{key}" 
 			self.instance_variable_set(variable_name, value)
		end

		# http://stackoverflow.com/questions/5646710/change-value-of-array-element-which-is-being-referenced-in-a-each-loop
		products = Product.all
		products.collect! {|product| (product.id == self.id) ? self : product}
		Product.write_csv(products)
		self
	end
end
