require 'faker'
require_relative '../lib/product'
# This file contains code that populates the database with
# fake data for testing purposes

# Use the faker gem to generate arrays with fake brands, 
# product names, and prices.

# Create 10 new Product objects, and save them to the 
# database

def db_seed
	brands = ["Crayola", "Lego", "Nintendo", "Fisher-Price", "Hasbro"]
	product_names = ["crayons", "house", "video game", "kitchen", "toy car"] 
	prices = ["2.00", "14.50", "2.10", "99.99", "19.99"] 

	100.times do
	  # you will write the "create" method as part of your project
	  Product.create( brand: brands.sample, 
	                  name: product_names.sample, 
	                  price: prices.sample )
	end	
end
