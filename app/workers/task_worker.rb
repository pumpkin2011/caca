class TaskWorker
  include Sidekiq::Worker

  def perform(task_id)
    t = Task.find(task_id)
    t.finish!
  end
end
