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
  has_one :order

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
    state :talking
    state :confirmed
    state :applying
    state :finished

    event :talk do
      transitions from: :pending, to: :talking
    end
    event :reject do
      transitions from: :talking, to: :pending
    end
    event :confirm do
      transitions from: :talking, to: :confirmed
    end
    event :apply  do
     transitions from: :confirmed, to: :applying
    end
    event :finish  do
     transitions from: :applying, to: :finished
    end

  end
end
