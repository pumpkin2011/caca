class Admin::DeliversController < ApplicationController
  before_action :count, only: [:index]

  def index
    @pending_count = Deliver.pending.count
    @confirmed_count = Deliver.confirmed.count
    @rejected_count = Deliver.rejected.count
    unless %w(pending confirmed rejected).include?( params[:type] )
      params[:type] = 'pending'
    end
    @delivers = Deliver.send(params[:type].to_sym)
  end


  # 地址审核: 拒绝
  def reject
    begin
      Deliver.pending.find( params[:id] ).reject!
      flash[:success] = '地址审核成功: 拒绝'
    rescue ActiveRecord::RecordNotFound
      flash[:error] = '地址审核失败: 数据无效'
    end
    redirect_to admin_delivers_path
  end

  # 地址审核: 通过
  def confirm
    begin
      Deliver.pending.find( params[:id] ).confirm!
      flash[:success] = '地址审核成功: 同意'
    rescue ActiveRecord::RecordNotFound
      flash[:error] = '地址审核失败: 数据无效'
    end
    redirect_to admin_delivers_path
  end

  private
    def count
      @pending_count = Deliver.pending.count
      @confirmed_count = Deliver.confirmed.count
      @rejected_count = Deliver.rejected.count
    end
end
