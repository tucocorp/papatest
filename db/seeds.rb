# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Companies
companies = %w[burgerking papajohns mcdonalds kfc wendys]

companies.each { |company| Company.create(subdomain: company) }

# Products
Product.create(name: 'Pizza Pepperoni', sku: 'pizza-pepp', type: 'Pizza', price: 9990)
Product.create(name: 'Pizza Carne', sku: 'pizza-carne', type: 'Pizza',  price: 5990)
Product.create(name: 'Pizza Vegan', sku: 'pizza-vegan', type: 'Pizza',  price: 7990)
Product.create(name: 'Salsa de Tomate', sku: 'salsa-tomat', type: 'Complement', price: 990)

# Stores
