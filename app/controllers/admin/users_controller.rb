class Admin::UsersController < ApplicationController
  def index
    @count = User.all.count
    @uploading_count = User.uploading.count
    @pending_count = User.pending.count
    @checked_count = User.checked.count
    @officialed_count = User.officialed.count

    if %w(uploading pending checked officialed_).include?( params[:type] )
      @users = User.page(params[:page]).send(params[:type].to_sym)
    else
      @users = User.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def reject

    @user = User.find( params[:id] )
    if @user.check_out!
      flash[:success] = '用户审核成功: 拒绝'

    else
      flash[:error] = '用户审核失败'
    end
    redirect_to admin_user_path(@user)
  end

  def confirm
    @user= User.pending.find( params[:id] )
    if @user.check_in!
      flash[:success] = '用户审核成功: 同意'

    else
      flash[:error] = '用户审核失败'
    end
    redirect_to admin_user_path(@user)
  end

  def official
    @user= User.checked.find( params[:id] )
    if @user.official!
      flash[:success] = '歪淘认证成功'

    else
      flash[:error] = '歪淘认证失败'
    end
    redirect_to admin_user_path(@user)
  end

  def cancel_official
    @user= User.officialed.find( params[:id] )
    if @user.cancel_official!
      flash[:success] = '取消歪淘认证成功'

    else
      flash[:error] = '取消歪淘认证失败'
    end
    redirect_to admin_user_path(@user)
  end
end
