class Admin::DepositsController < ApplicationController
  def index
    @deposit = Deposit.new
    @deposits = Deposit.all
  end


  def create
    @deposit = current_admin.deposits.build( deposit_param )
    if @deposit.save
      flash[:success] = '充值成功'
      redirect_to admin_deposits_path
    else
      @deposits = Deposit.all
      render :index
    end

  end

  private
    def deposit_param
      params.require(:deposit).permit(:sn, :amount)
    end
end
