# == Schema Information
#
# Table name: shops
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  account    :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shops_on_user_id  (user_id)
#

class Shop < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :account
  validates :account, length: { minimum: 3, maximum: 25},
          uniqueness: true, allow_blank: true

  validate :shops_count_within_limit, on: :create

  private
    def shops_count_within_limit
      errors.add(:base, "最多可绑定3个掌柜")if self.user.shops(:reload).count >= 3
    end
end
