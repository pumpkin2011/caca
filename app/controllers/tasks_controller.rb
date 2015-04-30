class TasksController < ApplicationController
  def index
    @tasks = Task.pending
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
      redirect_to my_task_path
    else
      render :new
    end
  end

  def my
    @tasks = current_user.tasks
  end

  def destroy
    Task.pending.find(params[:id]).destroy
    flash[:success] = '任务取消成功'
    redirect_to my_task_path
  end

  private
    def task_param
      params.require(:task).permit!
    end
end
