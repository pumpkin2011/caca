# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  producer_id      :integer
#  consumer_id      :integer
#  shop_id          :integer
#  wangwang_id      :integer
#  ip               :string(20)
#  link             :string(255)
#  keywords         :string(255)
#  price            :decimal(10, 2)
#  duration         :string(10)
#  level            :string(10)
#  chat             :string(10)
#  desc             :string(255)
#  spec             :string(255)
#  receive_time     :boolean
#  comment_time     :boolean
#  comment          :string(255)
#  extra            :string(10)
#  state            :string(10)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commission       :decimal(10, 2)
#  commission_extra :decimal(10, 2)
#  task_type        :string(10)
#  cover            :string(255)
#
# Indexes
#
#  index_tasks_on_consumer_id  (consumer_id)
#  index_tasks_on_duration     (duration)
#  index_tasks_on_extra        (extra)
#  index_tasks_on_ip           (ip)
#  index_tasks_on_level        (level)
#  index_tasks_on_producer_id  (producer_id)
#  index_tasks_on_shop_id      (shop_id)
#  index_tasks_on_state        (state)
#  index_tasks_on_task_type    (task_type)
#  index_tasks_on_wangwang_id  (wangwang_id)
#

class Task < ActiveRecord::Base
  extend Enumerize
  include AASM

  default_scope { order 'updated_at DESC'}

  # 商家
  belongs_to :producer, class_name: 'User'
  # 刷手
  belongs_to :consumer, class_name: 'User'
  # 店铺
  belongs_to :shop
  # 旺旺
  belongs_to :wangwang

  def cover_url
    self.cover.blank? ? 'helen.jpg' : ENV['QINIU_BUCKET_DOMAIN']+self.cover+'-task'
  end

  def commission_for_consumer
    self.commission * 0.8
  end

  enumerize :duration, in: [
    :three, :six, :ten, :fifteen, :twenty, :twentyfive,
    :thirty, :forty
  ], default: :three

  enumerize :level, in: [
    :normal, :one, :two,:three, :four, :five, :max
  ], default: :normal

  enumerize :chat, in: [
    :normal, :simple, :complex
  ], default: :normal

  enumerize :task_type, in: [
    :pc, :phone
  ], default: :pc



  aasm column: :state do
    state :pending, initial: true
    state :talking
    state :confirmed
    state :applying
    state :finished

    event :talk do
      transitions from: :pending, to: :talking
    end
    event :reject do
      transitions from: [:confirmed, :talking], to: :pending
    end
    event :confirm do
      transitions from: :talking, to: :confirmed
    end

    event :apply  do
     transitions from: :confirmed, to: :applying
    end

    event :finish  do
      after do
        self.consumer.with_lock do
          self.consumer.increment(:amount, self.commission_for_consumer)
          self.consumer.save
        end
      end
     transitions from: :applying, to: :finished
    end

  end

  validates_presence_of :shop_id, :link, :keywords,
                        :price, :duration, :level,
                        :chat, :task_type, :desc, :cover
  validates :link, format: {with: /id=\d+/}, allow_blank: true
  validates :price, :commission_extra, numericality:true, allow_blank: true
  validates :extra, numericality:{ only_integer: true}, allow_blank: true

  validate :commission_within_limit, on: :create

  # 发布任务扣除佣金
  after_create do |task|
    task.producer.with_lock do
      task.producer.decrement(:amount, task.commission)
      task.producer.save
    end
  end

  # 取消任务返还资金
  before_destroy do |task|
    task.producer.with_lock do
      task.producer.increment(:amount, task.commission)
      task.producer.save
    end
  end

  # 任务完成支付佣金给刷手
  def self.finish_task
    applying.where('updated_at < ?', 5.minutes.ago).each do |task|
      TaskWorker.perform_async(task.id)
    end
  end

  private
    # 计算佣金总额
    def commission_within_limit
      # 基础价格
      self.commission = 3
      # 时长增加
      case self.duration
      when 'six'
        self.commission += 1
      when 'ten'
        self.commission += 2
      when 'fifteen'
        self.commission += 3
      when 'twenty'
        self.commission += 4
      when 'twentyfive'
        self.commission += 5
      when 'thirty'
        self.commission += 6
      when 'forty'
        self.commission += 7
      end
      # 假聊
      case self.chat
      when 'simple'
        self.commission += 0.5
      when 'complex'
        self.commission += 1
      end

      # 手机单
      self.commission += 1 if self.task_type == 'phone'

      # 增拍
      self.commission += self.extra.to_i.abs * 2

      # 追加佣金
      self.commission += self.commission_extra.to_i.abs
      errors.add(:base, '余额不足') if self.commission > self.producer.amount
    end
end
