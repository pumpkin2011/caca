# == Schema Information
#
# Table name: complaints
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  question       :text
#  answer         :text
#  state          :string(10)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  task_id        :integer
#  reason         :string(20)
#
# Indexes
#
#  index_complaints_on_state           (state)
#  index_complaints_on_target_user_id  (target_user_id)
#  index_complaints_on_task_id         (task_id)
#  index_complaints_on_user_id         (user_id)
#

class Complaint < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :task
  belongs_to :target_user, class_name: 'User'
  has_many :pictrues, as: :imageable
  accepts_nested_attributes_for :pictrues

  attr_accessor :username
  attr_accessor :task_no

  before_validation :set_target, on: :create
  validates_presence_of :username, :reason, :question, on: :create
  validates_length_of :reason, in: 5..20, allow_blank: true


  validate :task_info,  on: :create

  aasm column: :state do
    state :pending, initial: true
    state :finished

    event :finish do
      transitions from: :pending, to: :finished
    end
  end

  private
    def set_target
      self.target_user = User.where(name: self.username).first
      self.task = Task.where(code: self.task_no).first
    end
    # TODO: 图片数量限制
    # def pictrues_count_limit
    #   unless (1..5).include?(self.pictrues.count)
    #     errors.add(:base, '需要上传1-5张图片')
    #   end
    # end

    def task_info
      # 任务存在性
      if task.nil?
        errors.add(:base, '任务ID错误')
        return
      end

      # 信息正确性
      if [self.task.producer_id, self.task.consumer_id].include?(self.user_id)
        if self.target_user.nil? || self.user_id == self.target_user_id
          errors.add(:base, '对方信息错误错误')
        end
      else
        errors.add(:base, '您没有参与该任务')
      end

    end
end
