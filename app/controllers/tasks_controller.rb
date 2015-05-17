class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :producer, only: [:new, :create]
  before_action :consumer, only: [:edit, :update]

  def index
    @tasks = Task.pending.includes(:shop)
  end

  def new
    # 数据自动填充: 来自模版->上次成功纪录->新内容
    if params[:template]
      @task = Task.new(JSON.parse(current_user.templates.find(params[:template]).content))
    elsif cookies[:task_param]
      @task = Task.new(JSON.parse(cookies[:task_param]))
    else
      @task = Task.new(receive_time: true, comment_time: true)
    end
  end


  def create
    @task = current_user.tasks.build(task_param)
    if @task.save
      flash[:success] = "任务发布成功"
      cookies[:task_param] = JSON.generate(task_param)
      redirect_to my_task_tasks_path
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    render :new
  end

  def validate
    @task = Task.find(params[:id])
    if @task.link.match(/id=\d+/).to_a[0] == params[:link].match(/id=\d+/).to_a[0]
      @task.apply!
      flash[:success] = '宝贝地址验证成功'
    else
      flash[:error] = '宝贝地址验证失败'
    end
    redirect_to task_path(@task)
  end

  def edit
    @task = Task.pending.find(params[:id])
    if current_user.frozen_amount < @task.price
      flash[:error] = '目前冻结的资金不能接手改任务'
      redirect_to deposits_path
      return
    end
  end

  def update
    @task = Task.pending.find(params[:id])
    @task.consumer = current_user
    @task.ip = request.remote_ip
    @task.talk
    if @task.update(task_consumer_param)
      redirect_to my_order_tasks_path
    else
      render :edit
    end
  end

  def my_task
    @pending_count = current_user.tasks.pending.count
    @talking_count = current_user.tasks.talking.count
    @confirmed_count = current_user.tasks.confirmed.count
    @applying_count = current_user.tasks.applying.count
    @all_count = current_user.tasks.count

    if %w(pending talking confirmed applying).include?( params[:type] )
      @tasks = current_user.tasks.send(params[:type].to_sym)
    else
      @tasks = current_user.tasks
    end
  end

  def my_order
    @pending_count = current_user.orders.pending.count
    @talking_count = current_user.orders.talking.count
    @confirmed_count = current_user.orders.confirmed.count
    @applying_count = current_user.orders.applying.count
    @all_count = current_user.orders.count

    if %w(pending talking confirmed applying).include?( params[:type] )
      @tasks = current_user.orders.send(params[:type].to_sym)
    else
      @tasks = current_user.orders
    end
  end


  def reject
    @task = current_user.tasks.find(params[:id])
    @task.ip = nil
    @task.wangwang_id = nil
    @task.consumer= nil
    @task.reject
    if @task.save

      flash[:success] = '审核操作成功: 拒绝'
      redirect_to my_task_tasks_path
    end
  end

  def confirm
    @task = current_user.tasks.find(params[:id])
    if @task.confirm!
      flash[:success] = '审核操作成功: 通过'
      redirect_to my_task_tasks_path
    end
  end

  def destroy
    current_user.tasks.find(params[:id]).destroy
    flash[:success] = '任务取消成功'
    redirect_to my_task_tasks_path
  end


  private
    def task_param
      params.require(:task).permit!
    end

    def task_consumer_param
      params.require(:task).permit(:wangwang_id)
    end

    # 商家验证
    def producer
      @shops = current_user.shops.confirmed
      if @shops.blank?
        flash[:error] = '发布任务前需要绑定店铺掌柜'
        redirect_to shops_path
        return
      end

      if current_user.frozen_amount < 100
        flash[:error] = '发布任务前需要申请冻结资金100元'
        redirect_to deposits_path
        return
      end

      unless ['checked', 'officialed'].include?(current_user.state)
        flash[:error] = '发布任务前需要进行账户认证'
        redirect_to edit_authenticates_path
        return
      end
    end

    # 刷手验证
    def consumer
      @wangwangs = current_user.wangwangs.available
      if current_user.deliver.blank?
        flash[:error] = '接手任务需要有收获地址'
        redirect_to delivers_path
        return
      end
      if @wangwangs.blank?
        flash[:error] = '接手任务前需要绑定旺旺'
        redirect_to wangwangs_path
        return
      end

      unless ['checked', 'officialed'].include?(current_user.state)
        flash[:error] = '接手任务前需要进行账户认证'
        redirect_to edit_authenticates_path
        return
      end
    end

end
