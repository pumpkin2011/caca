# == Schema Information
#
# Table name: page_categories
#
#  id         :integer          not null, primary key
#  name       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageCategory < ActiveRecord::Base
  has_many :pages, foreign_key: 'category_id'
end
