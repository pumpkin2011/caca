# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
# Indexes
#
#  index_pages_on_category_id  (category_id)
#

class Page < ActiveRecord::Base
  belongs_to :category, class_name: 'PageCategory'
  validates_presence_of :name, :code, :content
end
