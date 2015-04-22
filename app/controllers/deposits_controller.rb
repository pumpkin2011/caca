class DepositsController < ApplicationController
  def index
    @deposit = Deposit.new
    @deposits = current_user.deposits
  end

  #TODO: 机器恶意充值处理
  def create
    @depost = Deposit.where( deposit_param ).pending.take
    begin
      if @depost.update(user: current_user)
        logger.info "[success][#{Time.now}][deposits][#{current_user.id}]: #{deposit_param[:sn]}-#{deposit_param[:amount]}"
        flash[:success] = "充值成功"
      end
    rescue Exception => e
      logger.error "[error][#{Time.now}][deposits][#{current_user.id}]: #{deposit_param[:sn]}-#{deposit_param[:amount]}"
      flash[:error] = "充值失败"
    end
    redirect_to deposits_path
  end

  private
    def deposit_param
      params.require(:deposit).permit(:sn, :amount)
    end


end
