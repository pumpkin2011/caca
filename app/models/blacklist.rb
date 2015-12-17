# == Schema Information
#
# Table name: blacklists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  target_id  :integer
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_blacklists_on_target_id  (target_id)
#  index_blacklists_on_user_id    (user_id)
#

class Blacklist < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, class_name: 'User'

  attr_accessor :username

  before_validation :set_target, on: :create
  validates_presence_of :username, on: :create
  # validates_uniqueness_of :target, scope: :user, message: '已屏蔽'
  validates_presence_of :target, on: :create, message: '不存在'
  validates :question, length: {in: 2..20} , allow_blank: true
  validate :count_within_limint, on: :create

  after_create Proc.new{|item|
    self.target.update(locked_at: 100.days.from_now) if Blacklist.where(target: self.target).count >= 10
  }

  private
    def set_target
      self.target = User.where(name: self.username).first
    end

    def count_within_limint
      errors.add(:base, '最多只能屏蔽10个用户') if Blacklist.where(user: self.user).count >= 10
    end
end
