class Admin::ExtractsController < ApplicationController

  def index

    @pending_count = Extract.pending.where('created_at > ?', 7.days.ago).count()
    @pending_total = Extract.pending.where('created_at > ?', 7.days.ago).sum(:amount)
    @finished_count = Extract.finished.count()
    @finished_total = Extract.finished.sum(:amount)
    @current_count = Extract.pending.where('created_at <= ?', 7.days.ago).count()
    @current_total = Extract.pending.where('created_at <= ?', 7.days.ago).sum(:amount)

    if params[:type] == 'pending'
      @extracts = Extract.pending.where('created_at > ?', 7.days.ago).includes(:user).page(params[:page])
    elsif params[:type] == 'finished'
      @extracts = Extract.finished.includes(:user).page(params[:page])
    else
      @extracts = Extract.pending.where('created_at <= ?', 7.days.ago).includes(:user).page(params[:page])

    end

  end

  # TODO: 弹出框处理
  def update
    @extract = Extract.pending.find(params[:id])
    @extract.channel = params[:type].to_sym
    @extract.finish
    if @extract.save
      flash[:success] = '操作成功'
    else
      flash[:success] = '操作失败'
    end
    redirect_to :back
  end
end
