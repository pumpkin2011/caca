class WangwangsController < ApplicationController
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

  private
    def wangwang_params
      params.require(:wangwang).permit(:account)
    end
end
