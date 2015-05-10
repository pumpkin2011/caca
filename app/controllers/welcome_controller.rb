class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end

  def profile

  end

  def frozen
    amount = params[:frozen_amount].to_i
    if amount == 0
      flash[:error] = '请输入要冻结的额度'
    elsif amount % 100 != 0
      flash[:error] = '冻结资金必须是100的倍数'
    elsif current_user.amount < amount
      flash[:error] = '冻结资金不能超过当前账户余额'
    else
      current_user.amount -= amount
      current_user.frozen_amount += amount
      if current_user.save
        flash[:success] = '冻结资金成功'
      end
    end
    redirect_to deposits_path

  end

  def qiniu_token

    uptoken = Qiniu.generate_upload_token(scope:ENV['QINIU_BUCKET'])

    render json: { uptoken: uptoken }
  end
end
