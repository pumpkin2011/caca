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

  def front_url
    self.front.blank? ? 'helen.jpg' : ENV['QINIU_BUCKET_DOMAIN']+self.front+'-authenticates'
  end

  def back_url
    self.back.blank? ? 'helen.jpg' : ENV['QINIU_BUCKET_DOMAIN']+self.back+'-authenticates'
  end

  def handheld_url
    self.handheld.blank? ? 'helen.jpg' : ENV['QINIU_BUCKET_DOMAIN']+self.handheld+'-authenticates'
  end
  validates_presence_of :name, :number, :front, :back, :handheld
  validates :name, length: {in: 2..6}, allow_blank: true
  validates :number, uniqueness:true, length: {is: 18}, allow_blank: true
end
