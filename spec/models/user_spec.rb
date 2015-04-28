require 'rails_helper'

describe User do
  context 'validations' do
    subject { build(:user) }

    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(24)}
  end
end
