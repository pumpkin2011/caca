class Admin::WangwangsController < ApplicationController
  def index
    @count = Wangwang.count
    @pending_count = Wangwang.pending.count
    @confirmed_count = Wangwang.confirmed.count
    @rejected_count = Wangwang.rejected.count

    if %w(pending confirmed rejected).include?( params[:type] )
      @wangwangs = Wangwang.page(params[:page]).send(params[:type].to_sym)
    else
      @wangwangs = Wangwang.page(params[:page])
    end
  end

  # 旺旺审核: 拒绝
  def reject
    Wangwang.pending.find( params[:id] ).reject!
    flash[:success] = '旺旺审核成功: 拒绝'
    redirect_to :back
  end

  # 旺旺审核: 通过
  def confirm
    Wangwang.pending.find( params[:id] ).confirm!
    flash[:success] = '旺旺审核成功: 同意'
    redirect_to :back
  end
end
