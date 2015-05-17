# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(20)
#  qq                     :string(15)
#  amount                 :decimal(10, 2)   default(0.0)
#  frozen_amount          :decimal(10, 2)   default(0.0)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  state                  :string(10)
#  referral_token         :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_qq                    (qq)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_state                 (state)
#

require 'rails_helper'

describe User do
  context '数据验证' do
    subject { build(:user) }

    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(24)}
  end
end
