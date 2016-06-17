require 'faker'
require_relative '../lib/product'
# This file contains code that populates the database with
# fake data for testing purposes

# Use the faker gem to generate arrays with fake brands, 
# product names, and prices.

def db_seed
# Create 10 new Product objects, and save them to the 
# database
	10.times do
	  Product.create( brand: Faker::Company.name, 
	                  name: Faker::Commerce.product_name, 
	                  price: Faker::Commerce.price)
	end	
end
