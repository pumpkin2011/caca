class TaskAutoWorker
  include Sidekiq::Worker

  def perform(id)
    t = TaskAuto.find(id)
    t.publish
  end
end
