# == Schema Information
#
# Table name: wangwangs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account    :string(50)
#  state      :string(10)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wangwangs_on_state    (state)
#  index_wangwangs_on_user_id  (user_id)
#

class Wangwang < ActiveRecord::Base
  include AASM
  belongs_to :user

  validates_presence_of :account
  validates :account, length: { in: 3..20 },
            uniqueness: {scope: :user_id, case_sensitive: false}, allow_blank: true

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

  validate :wangwangs_count_within_limit, on: :create

  private
    def wangwangs_count_within_limit

      errors.add(:base, "最多可绑定50个旺旺帐号") if Wangwang.where(user: self.user).count >= 50
    end
end
