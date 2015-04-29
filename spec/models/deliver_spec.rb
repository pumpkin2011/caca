# == Schema Information
#
# Table name: delivers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  owner_id   :integer
#  name       :string(20)       not null
#  phone      :string(20)       not null
#  province   :string(6)        not null
#  city       :string(6)        not null
#  district   :string(6)        not null
#  town       :string(50)
#  address    :string(100)      not null
#  zip        :string(6)
#  state      :string(10)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  use_id     :integer
#
# Indexes
#
#  index_delivers_on_owner_id  (owner_id)
#  index_delivers_on_state     (state)
#  index_delivers_on_use_id    (use_id)
#  index_delivers_on_user_id   (user_id)
#

require 'rails_helper'

describe Deliver do
  context '数据验证' do
    subject { build(:deliver) }

    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(6) }

    it { should validate_presence_of(:phone)}
    it { should validate_length_of(:phone).is_equal_to(11) }
    it { should validate_numericality_of(:phone).only_integer }


    it { should validate_presence_of(:province) }
    it { should validate_length_of(:province).is_equal_to(6) }

    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_equal_to(6) }

    it { should validate_presence_of(:district) }
    it { should validate_length_of(:district).is_equal_to(6) }

    it { should validate_presence_of(:town) }
    it { should validate_length_of(:town).is_at_least(2).is_at_most(15) }

    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_least(5).is_at_most(20) }
  end

end
