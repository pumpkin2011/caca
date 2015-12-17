# == Schema Information
#
# Table name: bills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  log        :string
#  amount     :decimal(10, 2)
#  state      :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  total      :decimal(10, 2)
#  process    :string(10)
#
# Indexes
#
#  index_bills_on_process  (process)
#  index_bills_on_state    (state)
#  index_bills_on_user_id  (user_id)
#

class Bill < ActiveRecord::Base
  extend Enumerize
  belongs_to :user



  default_scope { order 'created_at DESC'}
  enumerize :state, in:[
    :deposit,
    :publish_task,
    :cancel_task,
    :finish_task,
    :extract,
    :frozen,
    :vip
  ]

  enumerize :process, in:[
    :finished,
    :pending
  ]

  after_create Proc.new{ |item|
    item.total = item.user.amount
    item.process = :finished
    item.process = :pending if item.state == :extract
    item.save
  }
end
