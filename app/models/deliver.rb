# == Schema Information
#
# Table name: delivers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(20)       not null
#  phone      :string(20)       not null
#  province   :string(6)        not null
#  city       :string(6)        not null
#  district   :string(6)        not null
#  town       :string(50)
#  address    :string(100)      not null
#  zip        :string(6)
#  state      :string(10)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  use_id     :integer
#  owner_id   :integer
#
# Indexes
#
#  index_delivers_on_owner_id  (owner_id)
#  index_delivers_on_state     (state)
#  index_delivers_on_use_id    (use_id)
#  index_delivers_on_user_id   (user_id)
#

class Deliver < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :owner, class_name: 'User'

  validates_presence_of :name, :phone, :province, :city, :district, :town,
                       :address
  validates_length_of :province, :city, :district, :zip, is: 6 , :allow_blank=>true


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
