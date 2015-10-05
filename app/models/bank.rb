# == Schema Information
#
# Table name: banks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  account    :string(255)
#  deposit    :string(255)
#  front      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_banks_on_user_id  (user_id)
#

class Bank < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :account, :deposit
  validates :name , length: {in: 2..10}, allow_blank: true
  validates :account, uniqueness:true,length:{in: 15..19}, allow_blank: true
  validates :deposit, length: {in: 4..20}, allow_blank: true
end
