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
#  shop_id     :integer
#
# Indexes
#
#  index_orders_on_ip           (ip)
#  index_orders_on_shop_id      (shop_id)
#  index_orders_on_state        (state)
#  index_orders_on_task_id      (task_id)
#  index_orders_on_user_id      (user_id)
#  index_orders_on_wangwang_id  (wangwang_id)
#

class Order < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :wangwang
  belongs_to :shop
  belongs_to :task

  aasm column: :state do
    state :talking, initial: true
    state :confirmed
    state :applying
    state :finished

    event :confirm do
      after do
        self.task.confirm!
      end
      transitions from: :talking, to: :confirmed
    end

    event :apply  do
     transitions from: :confirmed, to: :applying
    end

    event :finish do
      transitions from: :applying, to: :finished
    end
  end

  before_validation do |order|
    order.shop = order.task.shop
  end

  after_create do |order|
    order.task.talk!
  end

  before_destroy do |order|
    order.task.reject!
  end

  validate :ip_count_within_limit, :shop_wangwang_within_limit, on: :create
  validates_presence_of :wangwang_id

  private
    def ip_count_within_limit
      count = Order.where(user_id: self.user.id).where(ip: self.ip).where('created_at > ?', 1.days.ago).size
      errors.add(:base, "同一个IP地址24小时内最多接3个任务，请重启路由或更换IP地址") if count >=3
    end

    def shop_wangwang_within_limit
      count = Order.where(wangwang_id: self.wangwang_id)
                   .where(shop_id: self.shop_id)
                   .where('created_at >= ?', 30.days.ago).size

      errors.add(:base, "您所选择的旺旺在30天已经接手过该店铺的任务，请使用其他旺旺!") if count >=1
    end

end
