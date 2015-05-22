class ShopsController < ApplicationController
  before_action :authenticate_user!
  def index
    @shop = Shop.new
    @shops = current_user.shops
  end

  def create
    @shop = current_user.shops.build( shop_params )
    if @shop.save
      flash[:success] = '掌柜添加成功'
      redirect_to shops_path
    else
      @shops = current_user.shops.reload
      render :index
    end
  end

  def destroy
    @shop = current_user.shops.pending.find(params[:id])
    if @shop.destroy
      flash[:success] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to shops_path
  end

  private
    def shop_params
      params.require(:shop).permit(:account)
    end
end
