# == Schema Information
#
# Table name: deposits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_id   :integer
#  sn         :string(32)
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_deposits_on_admin_id  (admin_id)
#  index_deposits_on_sn        (sn) UNIQUE
#  index_deposits_on_user_id   (user_id)
#

class Deposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  default_scope { order 'created_at DESC'}

  validates :sn, presence: true, uniqueness: true, length: { is: 32 }
  validates :amount, presence: true,
        inclusion: { in: [10, 50, 100, 500]}

  before_update do |deposit|
    deposit.user.increment!(:amount, deposit.amount)
  end
end
