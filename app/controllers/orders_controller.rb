class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def new
    @task = Task.find(params[:task_id])
    @wangwangs = current_user.wangwangs.confirmed
  end

  def create
    @task = Task.find(params[:task_id])
    @order = @task.build_order(order_param)
    @order.user = current_user
    if @order.save
      flash[:success] = "接单成功"
      redirect_to orders_path
    else
      render :new
    end
  end

  def reject
    Order.find(params[:id]).destroy
    flash[:success] = '审核操作成功: 拒绝'
    redirect_to my_task_path
  end

  def confirm
    Order.find(params[:id]).confirm!
    flash[:success] = '审核操作成功: 通过'
    redirect_to my_task_path
  end

  private
    def order_param
      params.require(:order).permit(:wangwang_id)
    end
end
