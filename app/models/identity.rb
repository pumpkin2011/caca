# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  number     :string
#  front      :string
#  back       :string
#  handheld   :string
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

  validates_presence_of :name, :number, :front, :back
  validates :name, length: {in: 2..6}, allow_blank: true
  validates :number, uniqueness:true, length: {is: 18}, allow_blank: true
end
