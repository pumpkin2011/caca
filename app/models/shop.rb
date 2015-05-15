# == Schema Information
#
# Table name: shops
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account    :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(10)
#
# Indexes
#
#  index_shops_on_state    (state)
#  index_shops_on_user_id  (user_id)
#

class Shop < ActiveRecord::Base
  include AASM
  belongs_to :user
  has_many :tasks

  validates_presence_of :account
  validates :account, length: { minimum: 3, maximum: 25},
          uniqueness: true, allow_blank: true

  aasm column: :state do
    state :pending, initial: true
    state :confirmed
    state :rejected

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :confirm do
      transitions from: :pending, to: :confirmed
    end
  end

  def day_count
    self.tasks.where('created_at > ?', 1.days.ago).count
  end

  def week_count
    self.tasks.where('created_at > ?', 7.days.ago).count
  end

  def month_count
    self.tasks.where('created_at > ?', 30.days.ago).count
  end

  validate :shops_count_within_limit, on: :create

  private
    def shops_count_within_limit
      errors.add(:base, "最多可绑定50个掌柜") if Shop.where(user: self.user).count >= 50
    end
end
