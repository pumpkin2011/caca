class Admin::DeliversController < ApplicationController

  def index
    @count = Deliver.count
    @pending_count = Deliver.pending.count
    @confirmed_count = Deliver.confirmed.count
    @rejected_count = Deliver.rejected.count
    @applying_count = Deliver.applying.count
    if %w(pending confirmed rejected applying).include?( params[:type] )
      @delivers = Deliver.page(params[:page]).send(params[:type].to_sym)
    else
      @delivers = Deliver.page(params[:page]).per(2)
    end

  end


  # 地址审核: 拒绝
  def reject
    Deliver.pending.find( params[:id] ).reject!
    flash[:success] = '地址审核成功: 拒绝'
    redirect_to :back
  end

  # 地址审核: 通过
  def confirm
    Deliver.pending.find( params[:id] ).confirm!
    flash[:success] = '地址审核成功: 同意'
    redirect_to :back
  end

end
