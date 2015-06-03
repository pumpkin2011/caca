class BlacklistsController < ApplicationController
  def index
    @black = Blacklist.new
    @blacks = current_user.blacks.page(params[:page])
  end

  def create
    @black = current_user.blacks.build( black_param )
    unless @black.save
      @blacks = current_user.blacks.page(params[:page])

      render :index
    else
      flash[:success] = '屏蔽用户成功'
      redirect_to blacklists_path
    end
  end

  def destroy
    @black = Blacklist.find(params[:id])
    if @black.created_at <= 1.days.ago
      @black.destroy
      flash[:success] = '取消屏蔽成功'
      redirect_to blacklists_path
    end
  end

  private
    def black_param
      params.require(:blacklist).permit(:username, :question)
    end
end
