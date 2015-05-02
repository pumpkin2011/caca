# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  number     :string(255)
#  front      :string(255)
#  back       :string(255)
#  handheld   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#

class Identity < ActiveRecord::Base
  belongs_to :user
  mount_uploader :front, IdentityUploader
  mount_uploader :back, IdentityUploader
  mount_uploader :handheld, IdentityUploader
end
