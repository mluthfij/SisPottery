# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(username: 'admin', email: 'belajarrubyonrails12@gmail.com', password: '111111', admin: true)
User.create(username: 'luthfi', email: 'luthfujuliansyah48@gmail.com', password: '111111')

# Product.create(name: 'New', user_id: 1, price: '1999')

(1..100).each do |i|
    Product.create(name: "Product #{i}", user_id: 1, price: rand(15..100), created_at: Time.now - i.days, updated_at: Time.now - i.days)
end