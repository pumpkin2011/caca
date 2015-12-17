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

require 'rails_helper'

describe Admin do
  context '数据验证' do
    subject { build(:admin) }

    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(24)}
  end
end
