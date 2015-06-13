class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    # TODO: deivse 注册失败地址跳转
    @banner = true
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
        Bill.create(
          user: current_user,
          log: "-",
          amount: -amount,
          state: 'frozen',
        )
      end
    end
    redirect_to deposits_path

  end

  def unfrozen
    if current_user.tasks.where('updated_at > ?', 7.days.ago).any?
      flash[:error] = "您在7天之内有发布过任务暂时不能提现!"
    elsif current_user.orders.where('updated_at > ?', 30.days.ago).any?
      flash[:error] = "您在30天之内接手过任务暂时不能提现!"
    else
      current_user.amount += current_user.frozen_amount
      current_user.frozen_amount = 0
      if current_user.save
        flash[:success] = "解冻资金成功。"
      else
        flash[:error] = "解冻资金失败，请重试!"
      end
    end
    redirect_to :back

  end

  def qiniu_token

    uptoken = Qiniu.generate_upload_token(scope:ENV['QINIU_BUCKET'])

    render json: { uptoken: uptoken }
  end
end
