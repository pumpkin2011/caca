class ReferralsController < ApplicationController

  def index

  end

  def show
    if user_signed_in?
      flash[:error] = '请先退出登录'
      redirect_to root_path
    else
      begin
        user = User.find_by referral_token: params[:code]
        if user
          session[:target_id] = user.id
          session[:target_type] = user.class.name
        end
        redirect_to new_user_registration_path
      rescue Exception => e
        redirect_to new_user_registration_path
      end
    end
  end
end
