class Admin::ShopsController < ApplicationController
  def index
    @count = Shop.count
    @pending_count = Shop.pending.count
    @confirmed_count = Shop.confirmed.count
    @rejected_count = Shop.rejected.count

    if %w(pending confirmed rejected).include?( params[:type] )
      @shops = Shop.page(params[:page]).send(params[:type].to_sym)
    else
      @shops = Shop.page(params[:page])
    end

  end

  def reject
    Shop.pending.find( params[:id] ).reject!
    flash[:success] = '店铺审核成功: 拒绝'
    redirect_to :back
  end

  def confirm
    Shop.pending.find( params[:id] ).confirm!
    flash[:success] = '店铺审核成功: 同意'
    redirect_to :back
  end
end
