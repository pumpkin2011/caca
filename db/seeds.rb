require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Create User'
user_demo01 = User.create(
  email: 'demo01@waitaowang.com',password: 'password',confirmed_at: Time.now, amount: 1000,
  name: '测试用户_01', qq: 626431918
)
user_demo02 = User.create(
  email: 'demo02@waitaowang.com',password: 'password',confirmed_at: Time.now, amount: 1000,
  name: '测试用户_02', qq: 378753833
)

puts 'Create Admin'
Admin.create(email: 'admin@waitaowang.com', password: 'password')

puts 'Create Deliver'
Deliver.create(user: user_demo01,
  name: Faker::Name.name, phone: Faker::Number.number(11),
  province: 110000, city: 110200, district: 110101,
  town: Faker::Address.street_name, address: Faker::Address.street_address,
  zip: Faker::Number.number(6), state: 'confirmed'
)
Deliver.create(user: user_demo01,
  name: Faker::Name.name, phone: Faker::Number.number(11),
  province: 120000, city: 120200, district: 120221,
  town: Faker::Address.street_name, address: Faker::Address.street_address,
  zip: Faker::Number.number(6), state: 'confirmed'
)
Deliver.create(user: user_demo01,
  name: Faker::Name.name, phone: Faker::Number.number(11),
  province: 130000, city: 130100, district: 130202,
  town: Faker::Address.street_name, address: Faker::Address.street_address,
  zip: Faker::Number.number(6), state: 'confirmed'
)
Deliver.create(user: user_demo02,
  name: Faker::Name.name, phone: Faker::Number.number(11),
  province: 340000, city: 340600, district: 340621,
  town: Faker::Address.street_name, address: Faker::Address.street_address,
  zip: Faker::Number.number(6), state: 'confirmed'
)
Deliver.create(
  user: user_demo02,
  name: Faker::Name.name, phone: Faker::Number.number(11),
  province: 130000, city: 341300, district: 341302,
  town: Faker::Address.street_name, address: Faker::Address.street_address,
  zip: Faker::Number.number(6), state: 'confirmed'
)

puts "Create Wangwang"
5.times do
  Wangwang.create(user: user_demo01, account: Faker::Name.name*2, state: 'confirmed')
end
5.times do
  Wangwang.create(user: user_demo02, account: Faker::Name.name*2, state: 'confirmed')
end

puts "Create Shop"
2.times do
  Shop.create(user: user_demo01, account: Faker::Name.name*2, state: 'confirmed')
end
2.times do
  Shop.create(user: user_demo02, account: Faker::Name.name*2, state: 'confirmed')
end
