FactoryGirl.define do
  factory :deliver do
    association :user
    name { Faker::Name.name }
    phone { Faker::Number.number(11) }
    province { Faker::Number.number(6) }
    city { Faker::Number.number(6) }
    district { Faker::Number.number(6) }
    town { Faker::Address.street_name }
    address { Faker::Address.street_address }
    zip { Faker::Number.number(6) }
  end
end
