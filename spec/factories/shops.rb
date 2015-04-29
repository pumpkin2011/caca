# == Schema Information
#
# Table name: shops
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account    :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(10)
#
# Indexes
#
#  index_shops_on_state    (state)
#  index_shops_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :shop do
    association :user
    account {Faker::Name.name*2}
  end
end
