FactoryGirl.define do
  factory :wangwang do
    association :user
    account {Faker::Name.name*2}
  end
end
