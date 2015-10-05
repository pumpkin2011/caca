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

  validates_presence_of :amount, on: :create
  validates :amount, numericality:{
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: Proc.new {|extract| extract.user.amount}
            },
            allow_blank: true, on: :create


  default_scope { order 'created_at DESC'}

  enumerize :channel, in:[
    :bank,
    :alipay
  ]
  after_create{|extract|
    extract.user.decrement!(:amount, extract.amount)
    Bill.create(
      user: extract.user,
      log: extract.id,
      amount: -extract.amount,
      state: 'extract',
    )
  }
  aasm column: :state do
    state :pending, initial: true
    state :finished


    event :finish do
      after do
        b = Bill.where(log: self.id, process: 'pending').first
        b.update(process: 'finished')
      end
      transitions from: :pending, to: :finished
    end
  end
end
