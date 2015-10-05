class Admin::ComplaintsController < ApplicationController
  def index

    @count = Complaint.all
    @pending_count = Complaint.pending.count
    @finished_count  = Complaint.finished.count
    if %w(pending finished).include?( params[:type] )
      @complaints = Complaint.page(params[:page]).send(params[:type].to_sym)
    else
      @complaints = Complaint.page(params[:page])
    end
  end

  def show
    @complaint = Complaint.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  def finished
    @user= Complaint.pending.find( params[:id] )
    if @user.finish!
      flash[:success] = '投诉处理成功'
    else
      flash[:error] = '投诉处理失败'
    end
    redirect_to :back
  end




end
