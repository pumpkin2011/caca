# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  amount                 :decimal(10, 2)   default(0.0)
#  frozen_amount          :decimal(10, 2)   default(0.0)
#  name                   :string(20)
#  qq                     :string(15)
#  state                  :string(10)
#  referral_token         :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_qq                    (qq)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_state                 (state)
#

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "demo_#{n}@example.com"}
    password 'password'
    confirmed_at { Time.now }
  end
end
