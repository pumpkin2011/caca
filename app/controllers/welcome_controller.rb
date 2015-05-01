class WelcomeController < ApplicationController
  def index
  end

  def profile

  end

  def frozen
    amount = params[:frozen_amount].to_i

    if amount % 100 != 0
      flash['error'] = '充值金额必须是100的倍数'
    elsif current_user.amount < amount
      flash[:error] = '冻结资金不能超过当前账户余额'
    else
      current_user.amount -= amount
      current_user.frozen_amount += amount
      if current_user.save
        flash[:success] = '冻结资金成功'
      end
    end
    redirect_to profile_path

  end
end
