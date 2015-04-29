FactoryGirl.define do
  factory :admin do
    sequence(:email) {|n| "demo_#{n}@example.com"}
    password 'password'
  end
end
