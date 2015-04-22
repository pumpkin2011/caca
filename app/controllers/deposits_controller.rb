class DepositsController < ApplicationController
  def index
    @deposit = Deposit.new
    @deposits = current_user.deposits
  end

  def create
    @depost = Deposit.where( deposit_param ).pending.take
    @depost.user= current_user
    if @depost && @depost.save
      flash[:success] = "充值成功"
    else
      flash[:error] = "充值失败"
    end
    redirect_to deposits_path
  end

  private
    def deposit_param
      params.require(:deposit).permit(:sn, :amount)
    end


end
