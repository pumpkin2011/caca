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
#  ip          :string(20)
#
# Indexes
#
#  index_orders_on_ip           (ip)
#  index_orders_on_state        (state)
#  index_orders_on_task_id      (task_id)
#  index_orders_on_user_id      (user_id)
#  index_orders_on_wangwang_id  (wangwang_id)
#

FactoryGirl.define do
  factory :order do
    user nil
wangwang nil
task nil
state "MyString"
  end

end
