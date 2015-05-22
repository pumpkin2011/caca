class WangwangsController < ApplicationController
  before_action :authenticate_user!
  def index
    @wangwang = Wangwang.new
    @wangwangs = current_user.wangwangs
  end

  def create
    @wangwang = current_user.wangwangs.build( wangwang_params )
    if @wangwang.save
      flash[:success] = '旺旺添加成功'
      redirect_to wangwangs_path
    else
      @wangwangs = current_user.wangwangs
      render :index
    end
  end

  def destroy
    @wangwang = current_user.wangwangs.pending.find(params[:id])
    if @wangwang.destroy
      flash[:success] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to wangwangs_path
  end

  private
    def wangwang_params
      params.require(:wangwang).permit(:account)
    end
end
