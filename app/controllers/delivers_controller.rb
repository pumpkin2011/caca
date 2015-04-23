class DeliversController < ApplicationController
  def index
    @delivers = current_user.delivers
  end

  def new
    @deliver = Deliver.new
  end

  def create
    @deliver = current_user.delivers.build( deliver_params )
    if @deliver.save
      flash[:success] = '地址添加成功'
      redirect_to delivers_path
    else
      render :new
    end
  end

  private
  def deliver_params
    params.require(:deliver).permit(:name, :phone, :province, :city, :district, :town, :address, :zip)
  end
end
