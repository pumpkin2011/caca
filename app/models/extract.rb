# == Schema Information
#
# Table name: extracts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  amount     :decimal(10, 2)
#  channel    :string(10)
#  sn         :string(50)
#  state      :string(10)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_extracts_on_channel  (channel)
#  index_extracts_on_sn       (sn)
#  index_extracts_on_state    (state)
#  index_extracts_on_user_id  (user_id)
#

class Extract < ActiveRecord::Base
  extend Enumerize
  include AASM
  belongs_to :user

  validates_presence_of :amount
  validates :amount, numericality:{
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: Proc.new {|extract| extract.user.amount}
            },
            allow_blank: true


  default_scope { order 'created_at DESC'}

  # enumerize :state, in:[
  #   :bank,
  #   :alipay
  # ]
  after_create{|extract|
    extract.user.decrement!(:amount, extract.amount)
    Bill.create(
      user: extract.user,
      log: "提现: #{extract.id}",
      amount: -extract.amount,
      state: 'extract',
    )
  }
  aasm column: :state do
    state :pending, initial: true
    state :finished


    event :finish do
      transitions from: :pending, to: :finished
    end
  end
end
