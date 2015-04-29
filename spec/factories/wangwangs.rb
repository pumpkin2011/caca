# == Schema Information
#
# Table name: wangwangs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account    :string(50)
#  state      :string(10)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wangwangs_on_state    (state)
#  index_wangwangs_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :wangwang do
    association :user
    account {Faker::Name.name*2}
  end
end
