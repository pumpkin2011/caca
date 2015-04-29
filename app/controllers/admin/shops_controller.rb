class Admin::ShopsController < ApplicationController
  def index
    @pending_count = Shop.pending.count
    @confirmed_count = Shop.confirmed.count
    @rejected_count = Shop.rejected.count

    unless %w(pending confirmed rejected).include?( params[:type] )
      params[:type] = 'pending'
    end
    @shops = Shop.send(params[:type].to_sym)
  end

  def reject
    Shop.pending.find( params[:id] ).reject!
    flash[:success] = '店铺审核成功: 拒绝'
    redirect_to admin_wangwangs_path
  end

  def confirm
    Shop.pending.find( params[:id] ).confirm!
    flash[:success] = '店铺审核成功: 同意'
    redirect_to admin_wangwangs_path
  end
end
