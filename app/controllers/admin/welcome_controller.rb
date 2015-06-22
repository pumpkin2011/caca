class Admin::WelcomeController < ApplicationController
  def index
    # 用户
    @all_user_count = User.all.count
    @uploading_user_count = User.uploading.count
    @pending_user_count = User.pending.count
    @checked_user_count = User.checked.count
    @officialed_user_count = User.officialed.count
    @locked_user_count = User.where.not(locked_at: nil).count
    #  佣金
    @commission_total = Task.finished.sum(:commission)
    # 充值
    @deposit_total = Deposit.sum(:amount)
    @deposit_applying_total = Deposit.applying.sum(:amount)
    # 提现
    @extract_finished_total = Extract.finished.sum(:amount)
    @extract_pending_total = Extract.pending.where('created_at > ?', 7.days.ago).sum(:amount)
    @extract_current_total = Extract.pending.where('created_at <= ?', 7.days.ago).sum(:amount)
    # 地址
    @deliver_count = Deliver.count
    @deliver_pending_count = Deliver.pending.count
    @deliver_confirmed_count = Deliver.confirmed.count
    @deliver_rejected_count = Deliver.rejected.count
    @deliver_applying_count = Deliver.applying.count
    # 旺旺
    @wangwang_count = Wangwang.count
    @wangwang_pending_count = Wangwang.pending.count
    @wangwang_confirmed_count = Wangwang.confirmed.count
    @wangwang_rejected_count = Wangwang.rejected.count
    # 店铺
    @shop_count = Shop.count
    @shop_pending_count = Shop.pending.count
    @shop_confirmed_count = Shop.confirmed.count
    @shop_rejected_count = Shop.rejected.count
  end
end
