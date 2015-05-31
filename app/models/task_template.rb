# == Schema Information
#
# Table name: task_templates
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(20)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_task_templates_on_user_id  (user_id)
#

class TaskTemplate < ActiveRecord::Base
  belongs_to :user
  has_many :auto, class_name: 'TaskAuto', foreign_key: :template_id, dependent: :destroy
  validates :name, presence: true, uniqueness: {scope: :user_id}, length: {in: 2..10 }
end
