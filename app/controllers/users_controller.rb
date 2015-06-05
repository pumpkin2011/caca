class UsersController < ApplicationController
  include DeliversHelper
  before_action :authenticate_user!

  def profile

    # 真实姓名
    # 支付宝
    # 收获地址
    @task = Task.find(params[:id])

    render json: {
      name: @task.consumer.name,
      wangwang: @task.wangwang.account,
      deliver_name: @task.consumer.deliver.name,
      deliver_address: full_address(@task.consumer.deliver),
      order_count: @task.consumer.orders.finished.count,
      alipay_name: @task.consumer.alipay.name,
      alipay_account: @task.consumer.alipay.account
    }
  end
end
