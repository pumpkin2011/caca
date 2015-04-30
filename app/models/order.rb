# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  wangwang_id :integer
#  task_id     :integer
#  state       :string(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_orders_on_state        (state)
#  index_orders_on_task_id      (task_id)
#  index_orders_on_user_id      (user_id)
#  index_orders_on_wangwang_id  (wangwang_id)
#

class Order < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :wangwang
  belongs_to :task

  aasm column: :state do
    state :talking, initial: true
    state :confirmed
    event :confirm do
      after do
        self.task.confirm!
      end
      transitions from: :talking, to: :confirmed
    end
  end

  after_create do |order|
    order.task.talk!
  end

  before_destroy do |order|
    order.task.reject!
  end
end
