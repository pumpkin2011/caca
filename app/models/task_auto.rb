# == Schema Information
#
# Table name: task_autos
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  template_id   :integer
#  state         :string(10)
#  interval      :integer
#  total_count   :integer
#  process_count :integer          default(0)
#  faild_count   :integer          default(0)
#  next_at       :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_task_autos_on_state        (state)
#  index_task_autos_on_template_id  (template_id)
#  index_task_autos_on_user_id      (user_id)
#

class TaskAuto < ActiveRecord::Base
  include AASM



  belongs_to :user
  belongs_to :template, class_name: 'TaskTemplate'

  validates_presence_of :template_id, :interval, :total_count
  validates :interval, :total_count, numericality:{ only_integer: true}, allow_blank: true


  before_create Proc.new{ |auto|
    auto.next_at =  2.minutes.from_now
  }

  aasm column: :state do
    state :process, initial: true
    state :stoped
    state :finished

    event :start do
      transitions from: :stoped, to: :process
    end
    event :stop do
      transitions from: :process, to: :stoped
    end
    event :finish do
      transitions from: :process, to: :finished
    end
  end


end
