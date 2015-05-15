# == Schema Information
#
# Table name: bills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  log        :string(255)
#  amount     :decimal(10, 2)
#  state      :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bills_on_state    (state)
#  index_bills_on_user_id  (user_id)
#

class Bill < ActiveRecord::Base
  extend Enumerize
  belongs_to :user

  enumerize :state, in:[
    :deposit,
    :pulish_task,
    :cancel_task,
    :finish_task,
    :extract
  ]
end
