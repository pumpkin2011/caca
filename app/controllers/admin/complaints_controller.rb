class Admin::ComplaintsController < ApplicationController
  def index
    @complaints = Complaint.page(params[:page])
  end

  def show
    @complaint = Complaint.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end
  

end
