class Admin::DepositsController < ApplicationController
  def index
    @deposit = Deposit.new
    @deposits = Deposit.all
  end


  def create
    @deposit = current_admin.deposits.build( deposit_param )
    if @deposit.save

    else

    end
    redirect_to admin_deposits_path
  end

  private
    def deposit_param
      params.require(:deposit).permit(:sn, :amount)
    end
end
