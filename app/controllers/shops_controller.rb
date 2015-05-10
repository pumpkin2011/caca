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

  private
    def shop_params
      params.require(:shop).permit(:account)
    end
end
