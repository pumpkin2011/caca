# == Schema Information
#
# Table name: complaints
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  question       :text(65535)
#  answer         :text(65535)
#  state          :string(10)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_complaints_on_state           (state)
#  index_complaints_on_target_user_id  (target_user_id)
#  index_complaints_on_user_id         (user_id)
#

class Complaint < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :target_user, class_name: 'User'
  has_many :pictrues, as: :imageable
  accepts_nested_attributes_for :pictrues

  attr_accessor :username

  before_validation :set_target, on: :create
  validates_presence_of :username, on: :create
  validates_presence_of :target_user, on: :create, message: '不存在'

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
    end
end
