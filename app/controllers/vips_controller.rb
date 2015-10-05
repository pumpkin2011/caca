class VipsController < ApplicationController

  def show
    @vip = Vip.new
  end

  def create
    @vip = current_user.vips.build(pricing: params[:pricing])
    if @vip.save
      flash[:success] = 'VIP套餐购买成功'
      redirect_to :back
    else
      render :show
    end
  end
end
