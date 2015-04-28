FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    confirmed_at { Time.now }
  end
end
