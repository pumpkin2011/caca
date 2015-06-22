class Admin::WelcomeController < ApplicationController
  def index
    # 用户
    @all_user_count = User.all.count
    @locked_user_count = User.where.not(locked_at: nil).count

    #  佣金
    @commission_total = Task.sum(:commission)
    @commission_finished = Task.finished.sum(:commission)

    # 充值
    @deposit_total = Deposit.sum(:amount)
    @deposit_applying = Deposit.applying.sum(:amount)
  end
end
