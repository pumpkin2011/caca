# == Schema Information
#
# Table name: pictrues
#
#  id             :integer          not null, primary key
#  url            :string
#  imageable_id   :integer
#  imageable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Pictrue < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
