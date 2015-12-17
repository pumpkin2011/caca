# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_admins_on_email  (email) UNIQUE
#

FactoryGirl.define do
  factory :admin do
    sequence(:email) {|n| "demo_#{n}@example.com"}
    password 'password'
  end
end
