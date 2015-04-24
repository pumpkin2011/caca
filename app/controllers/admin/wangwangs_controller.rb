class Admin::WangwangsController < ApplicationController
  def index
    @pending_count = Wangwang.pending.count
    @confirmed_count = Wangwang.confirmed.count
    @rejected_count = Wangwang.rejected.count

    unless %w(pending confirmed rejected).include?( params[:type] )
      params[:type] = 'pending'
    end
    @wangwangs = Wangwang.send(params[:type].to_sym)
  end

  # 旺旺审核: 通过
  def reject
    Wangwang.pending.find( params[:id] ).reject!
    flash[:success] = '旺旺审核成功: 拒绝'
    redirect_to admin_wangwangs_path
  end

  # 旺旺审核: 通过
  def confirm
    Wangwang.pending.find( params[:id] ).confirm!
    flash[:success] = '旺旺审核成功: 同意'
    redirect_to admin_wangwangs_path
  end
end
