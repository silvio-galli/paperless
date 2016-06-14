# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
15.times do
  price = Faker::Number.decimal(3,2).to_d
  discount = rand(50..100).to_d
  promo = price - discount
  product = Product.create!(
    initiative: "#{Faker::Number.between(10, 13)}/2016",
    local_code: Faker::Number.number(7),
    description: Faker::Hipster.sentence(3, false),
    barcode: Faker::Number.number(13),
    default_price: price,
    promo_price: promo,
    quantity: rand(5..15),
    arriving_date: Faker::Time.between(DateTime.now, DateTime.now + 7)
  )
end

puts "Created #{Product.count} new products."
