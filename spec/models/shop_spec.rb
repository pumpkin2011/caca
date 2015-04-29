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

require 'rails_helper'

describe Shop do
  context '数据验证' do
    subject { build(:wangwang) }

    it { should be_valid }
    it { should validate_presence_of(:account) }
    it { should validate_uniqueness_of(:account).case_insensitive.scoped_to(:user_id) }
    it { should validate_length_of(:account).is_at_least(3).is_at_most(20)}
  end
  it '同一账户最多可绑定50个店铺' do
    user = create(:user)
    50.times { create(:shop, user: user)}
    expect(build(:shop, user: user)).not_to be_valid
  end


end
