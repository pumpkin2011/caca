FactoryGirl.define do
  factory :shop do
    association :user
    account {Faker::Name.name*2}
  end
end
