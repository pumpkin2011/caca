# == Schema Information
#
# Table name: delivers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  owner_id   :integer
#  name       :string(20)       not null
#  phone      :string(20)       not null
#  province   :string(6)        not null
#  city       :string(6)        not null
#  district   :string(6)        not null
#  town       :string(50)
#  address    :string(100)      not null
#  zip        :string(6)
#  state      :string(10)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_delivers_on_owner_id  (owner_id)
#  index_delivers_on_state     (state)
#  index_delivers_on_user_id   (user_id)
#

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
