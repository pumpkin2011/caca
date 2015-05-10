class UsersController < ApplicationController
  include DeliversHelper
  before_action :authenticate_user!
  
  def profile

    # 真实姓名
    # 支付宝
    # 收获地址
    @task = Task.find(params[:id])

    render json: {
      name: @task.order.user.identity.name,
      wangwang: @task.order.wangwang.account,
      deliver_name: @task.order.user.deliver.name,
      deliver_address: full_address(@task.order.user.deliver)
    }
  end
end
