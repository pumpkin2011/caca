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

  def self.process
    running.where('next_at <= ?', Time.now).each do |auto|
      TaskAutoWorker.perform_async(auto.id)
    end
  end

  def publish
    params = JSON.parse(self.template.content);
    params[:producer_id] = self.user.id
    t = Task.new(params)
    if t.save
      self.process_count += 1
      if self.process_count < self.total_count
        self.next_at = self.interval.to_i.minutes.from_now
      else
        self.state = :finished
        self.next_at = nil
      end
    else
      self.faild_count += 1

      if self.faild_count == 5
        self.state = :stoped
        self.next_at = nil
      else
        self.next_at = self.interval.to_i.minutes.from_now
      end
    end
    self.save
  end

  aasm column: :state do
    state :running, initial: true
    state :stoped
    state :finished

    event :start do
      transitions from: :stoped, to: :running
    end
    event :stop do
      transitions from: :running, to: :stoped
    end
    event :finish do
      transitions from: :running, to: :finished
    end
  end


end
