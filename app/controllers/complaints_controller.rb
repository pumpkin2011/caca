class ComplaintsController < ApplicationController
  def index
    @complaints = current_user.complaints
  end

  def new

    @complaint = Complaint.new
    task = Task.where(code: params[:task]).first
    if task
      @complaint.task_no = task.code
      if current_user.id == task.producer_id
        @complaint.username = task.consumer.name
      else
        @complaint.username = task.producer.name
      end
    end
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    if @complaint.save
      redirect_to complaints_path
    else
      render :new
    end
  end

  def show
    @complaint = current_user.complaints.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  private
    def complaint_params
      params.require(:complaint).permit(
        :task_no, :username, :question, :reason,
        pictrues_attributes: [:url]
      )
    end
end
