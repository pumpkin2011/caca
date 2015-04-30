class TasksController < ApplicationController
  def index
    @wangwangs = current_user.wangwangs.confirmed
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @shops = current_user.shops.confirmed
    if @shops.blank?
      flash[:error] = '发布任务前需要绑定店铺掌柜'
      redirect_to shops_path
    end

  end


  def create
    @task = current_user.tasks.build(task_param)
    if @task.save
      flash[:success] = "任务发布成功"
      redirect_to tasks_path
    else
      render :new
    end
  end

  private
    def task_param
      params.require(:task).permit!
    end
end
