# == Schema Information
#
# Table name: pictrues
#
#  id             :integer          not null, primary key
#  url            :string(255)
#  imageable_id   :integer
#  imageable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Pictrue < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
