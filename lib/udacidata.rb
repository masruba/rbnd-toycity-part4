require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@file_path_to_csv = File.dirname(__FILE__) + "/../data/data.csv"		
  
  def self.get_csv_contents
  	if File.exist?(@@file_path_to_csv) 
			csv_contents = CSV.open(@@file_path_to_csv, "rb")
			puts csv_contents
			# Skip the header row
			csv_contents.shift
			return csv_contents
		end
		return nil
  end

  def self.object_data_exists(id)
		CSV.foreach(@@file_path_to_csv, headers: true) do |row|
			if row["id"] == id
				return true
			end
		end
		return false
	end

	def delete_row(csv_row_number)
		csv = CSV.read(@@file_path_to_csv , headers:true)
		csv.delete(csv_row_number)
	end
	# Product.all should return an array of Product objects representing all the data in the database.
  def self.all
  	products_array = []
  	data = get_csv_contents
  	if data != nil
			data.each do |row|
				options = {id: row.id, brand: row["brand"], name: row["product"], price: row["price"]}
				products_array.push(Product.new(options))
			end  	
		end
  end

	def self.create(attributes = nil)
		# create the object
		obj = new attributes	
		# If the object's data is not in the database
		if object_data_exists(obj.id) == false
			# append the data in the database
    	CSV.open(@@file_path_to_csv, "a") do |csv|
      	csv << [obj.id, obj.brand, obj.name, obj.price]
    	end
    end
		# return the object
		return obj
	end 

 	def self.first
 		products = all
 		products.first
 	end

 	def self.first(n)
 		products = all
 		products.first(n)
 	end

 	def self.last
 		products = all
 		products.last
 	end

 	def self.last(n)
 		products = all
 		products.last(n)
 	end

 	def self.find(id)
 		find_by_id(id)
 	end

 	def self.destroy(id)
 		# raise ProductNotFoundError when the product can’t be destroyed because the given ID does not exist 		
		csv_row_number = object_data_exists(id)
 		raise ProductNotFoundError if csv_row_number == -1
 		delete_row(csv_row_number)
 	end

 	def self.update

 	end

 	def self.where(options={})
 	end 	
end

print Udacidata.all