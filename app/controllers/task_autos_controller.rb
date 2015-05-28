class TaskAutosController < ApplicationController

  def index
    @autos = current_user.autos
  end

  def create
    @auto = TaskAuto.new(auto_params)
    @auto.user = current_user

    if @auto.save
      flash[:flash] = "定时任务发布成功"
      redirect_to task_autos_path
    else
      flash[:error] = "定时任务发布失败"
      redirect_to :back
    end
  end


  private
    def auto_params
      params.require(:task_auto).permit(:template_id, :interval, :total_count)
    end
end
