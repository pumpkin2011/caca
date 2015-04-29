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

require 'rails_helper'

describe Wangwang do
  context '数据验证' do
    subject { build(:wangwang) }

    it { should be_valid }
    it { should validate_presence_of(:account) }
    it { should validate_uniqueness_of(:account).case_insensitive.scoped_to(:user_id) }
    it { should validate_length_of(:account).is_at_least(3).is_at_most(20)}
  end
  it '同一账户最多可绑定50个旺旺帐号' do
    user = create(:user)
    50.times { create(:wangwang, user: user)}
    expect(build(:wangwang, user: user)).not_to be_valid
  end


end
