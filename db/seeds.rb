# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Product.create(name: 'New', user_id: 1, price: '1999')

# User.destroy_all
# Keep.destroy_all
# Product.destroy_all

# User.update(username: 'admin1', email: 'belajarrubyonrails12@gmail.com', password: '111111', admin: true, user_id:2)


# if User.count < 2
# User.create(username: 'admin123', email: 'belajarrubyonrails12@gmail.com', password: '111111', admin: true)
# User.create(username: 'luthfi', email: 'luthfujuliansyah48@gmail.com', password: '111111')
# end

# if Product.count < 100
#     (1..100).each do |i|
#         Product.create(name: "Product #{i}", user_id: 1, price: rand(15..100), created_at: Time.now - i.days, updated_at: Time.now - i.days)
#     end
# end

# if Keep.count < 100
#     (1..100).each do |k|
#         # Keep.create(product_name: "Product #{i}", user_id: 1, product_price: rand(15..100), point: i, quantity: rand(1..50), created_at: Time.now - i.days, updated_at: Time.now - i.days)
#         # Keep.create(product_name: "Product #{i}", user_id: 1, product_price: rand(15..100), point: i, quantity: rand(1..50), created_at: Time.now - i.days, updated_at: Time.now - i.days)
#         Keep.create(bucket_id: 1, customer: "luthfi", product_name: "Product #{k}", product_price: rand(500000..2500000), quantity: rand(5..50), total_price: rand(500000..2500000), order_start: "0026-10-22", order_end: "2022-10-05", point: k, product_id: k, user_id: 2, created_at: Time.now - k.days, updated_at: Time.now - k.days)
#     end
# end

# Keep.create(bucket_id: 1, customer: "luthfi", product_name: "Product 100", product_price: 54, quantity: 3, total_price: 486, order_start: "0026-10-22", order_end: "2022-10-05", point: 200, user_id: 2)