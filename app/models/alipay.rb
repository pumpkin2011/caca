# == Schema Information
#
# Table name: alipays
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  account    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_alipays_on_user_id  (user_id)
#

class Alipay < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :account
  validates :name , length: {in: 2..10}, allow_blank: true
  validates :account, uniqueness:true, allow_blank: true
end
