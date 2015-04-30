# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  shop_id      :integer
#  type         :boolean
#  link         :string(255)
#  keywords     :string(255)
#  price        :decimal(10, 2)
#  duration     :string(10)
#  level        :string(10)
#  chat         :string(10)
#  desc         :string(255)
#  spec         :string(255)
#  receive_time :boolean
#  comment_time :boolean
#  comment      :string(255)
#  extra        :string(10)
#  state        :string(10)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_duration  (duration)
#  index_tasks_on_extra     (extra)
#  index_tasks_on_level     (level)
#  index_tasks_on_shop_id   (shop_id)
#  index_tasks_on_state     (state)
#  index_tasks_on_user_id   (user_id)
#

class Task < ActiveRecord::Base
  extend Enumerize

  include AASM
  belongs_to :user
  belongs_to :shop

  enumerize :duration, in: [
    :three, :six, :ten, :fifteen, :twenty, :twenty_five,
    :thirty, :forty
  ], default: :three

  enumerize :level, in: [
    :normal, :one, :two,:three, :four, :five, :max
  ], default: :normal

  enumerize :chat, in: [
    :normal, :simple, :complex
  ], default: :normal

  aasm column: :state do
    state :pending, initial: true
    state :confirmed
    state :rejected
    state :applying

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :apply  do
     transitions from: :confirmed, to: :applying
    end
  end
end
