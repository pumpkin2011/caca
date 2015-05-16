class DepositsController < ApplicationController
  before_action :authenticate_user!
  def index
    @deposit = Deposit.new
    @extract = Extract.new
    @deposits = current_user.deposits
  end

  #TODO: 机器恶意充值处理
  def create
    if deposit_param[:sn].blank?
      flash[:error] = "请输入充值流水号"
      redirect_to deposits_path
      return
    end

    if deposit_param[:amount].blank?
      flash[:error] = "没有选择充值"
      redirect_to deposits_path
      return
    end


    @depost = Deposit.pending.find_by!(deposit_param)
    @depost.apply
    if @depost.update(user: current_user)

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
