class TaskAutosController < ApplicationController
  before_action :find_auto , only: [:start, :stop, :destroy]

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

  def start
    flash[:success] = '任务已开始'
    @auto.next_at = @auto.interval.to_i.minutes.from_now
    @auto.state = :running
    @auto.faild_count = 0
    @auto.save
    redirect_to :back
  end

  def stop
    flash[:success] = '任务已暂停'
    @auto.next_at = nil
    @auto.state = :stoped
    @auto.save
    redirect_to :back
  end

  def destroy
    flash[:success] = '任务已删除'
    @auto.destroy
    redirect_to :back
  end

  private
    def auto_params
      params.require(:task_auto).permit(:template_id, :interval, :total_count)
    end

    def find_auto
      @auto = TaskAuto.find(params[:id])
    end
end
