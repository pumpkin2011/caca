class Admin::DepositsController < ApplicationController
  def index
    @deposit = Deposit.new
    @count = Deposit.count
    @pending_count = Deposit.pending.count
    @applying_count = Deposit.applying.count

    if %w(pending applying).include?( params[:type] )
      @deposits = Deposit.page(params[:page]).send(params[:type].to_sym)
    else
      @deposits = Deposit.page(params[:page])
    end
  end


  def create
    @deposit = current_admin.deposits.build( deposit_param )
    if @deposit.save
      logger.info "[success][#{Time.now}][admin][deposits][#{current_admin.id}]: #{deposit_param[:sn]}-#{deposit_param[:amount]}"
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
