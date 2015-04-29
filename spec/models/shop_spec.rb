require 'rails_helper'

describe Shop do
  context '数据验证' do
    subject { build(:wangwang) }

    it { should be_valid }
    it { should validate_presence_of(:account) }
    it { should validate_uniqueness_of(:account).case_insensitive.scoped_to(:user_id) }
    it { should validate_length_of(:account).is_at_least(3).is_at_most(20)}
  end
  it '同一账户最多可绑定3个店铺' do
    user = create(:user)
    3.times { create(:shop, user: user)}
    expect(build(:shop, user: user)).not_to be_valid
  end


end
