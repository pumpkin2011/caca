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
#  state      :string(10)
#
# Indexes
#
#  index_deposits_on_admin_id  (admin_id)
#  index_deposits_on_sn        (sn) UNIQUE
#  index_deposits_on_state     (state)
#  index_deposits_on_user_id   (user_id)
#

class Deposit < ActiveRecord::Base

  include AASM
  belongs_to :user
  belongs_to :admin


  default_scope { order 'created_at DESC'}
  scope :pending, ->{ where(user: nil)}

  validates_presence_of :sn, :amount
  validates :sn, uniqueness: true, length: { is: 32 }, allow_blank: true
  validates :amount, inclusion: { in: [10, 50, 100, 500]}, allow_blank: true

  after_update do |deposit|
    deposit.user.increment!(:amount, deposit.amount)
    Bill.create(
      user: deposit.user,
      log: "淘宝充值: #{deposit.sn}",
      amount: deposit.amount,
      state: 'deposit',
    )
  end

  aasm column: :state do
    state :pending, initial: true
    state :applying

    event :apply do
      transitions from: :pending, to: :applying
    end
  end
end
