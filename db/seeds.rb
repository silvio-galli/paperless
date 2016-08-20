# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
  user = User.create!(
    name: "#{Faker::Name.first_name}.#{Faker::Name.last_name}",
    password: "password",
    admin: false
  )
end

admin = User.create!(
  name: "silvio.galli",
  email: "sg@example.com",
  password: "helloworld",
  admin: true
)

users = User.all

60.times do
  price = Faker::Number.decimal(3,2).to_d
  discount = rand(50..100).to_d
  promo = price - discount
  status = rand(0..1)
  if status == 0
    choices = [ nil, Faker::Time.between(DateTime.now, DateTime.now - 7) ]
    arriving_date = choices.sample
  elsif status == 1
    arriving_date = Faker::Time.between(DateTime.now - 3, DateTime.now + 10)
  end
  current_user = users.sample
  product = Product.create!(
    initiative: "#{Faker::Number.between(10, 13)}/2016",
    local_code: Faker::Number.number(7),
    description: Faker::Hipster.sentence(3, false),
    barcode: Faker::Number.number(13),
    default_price: price,
    promo_price: promo,
    quantity: rand(5..15),
    status: status,
    arriving_date: arriving_date,
    user: current_user
  )
end

products = Product.all

50.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  customer = Customer.create!(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@#{Faker::Internet.domain_name}",
    phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.street_address,
    postcode: Faker::Address.postcode,
    city: Faker::Address.city,
    country: Faker::Address.country
  )
end

customers = Customer.all

80.times do
  order = Order.create!(
    customer: customers.sample
  )
end

orders = Order.all

100.times do
  order_item = OrderItem.create!(
    order: orders.sample,
    product: products.sample,
    quantity: rand(1..3)
  )
end

puts "Created #{Product.count} new products."
puts "Created #{Customer.count} new customers."
puts "Created #{User.count} new users."
puts "Created #{Order.count} new orders with #{OrderItem.count} items inside."
