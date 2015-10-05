# == Schema Information
#
# Table name: invitations
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  target_id    :integer
#  confirmed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_invitations_on_target_id  (target_id)
#  index_invitations_on_user_id    (user_id)
#

class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, class_name: 'User'

  def confirm!
    update_attribute(:confirmed_at, Time.zone.now)
  end
end
