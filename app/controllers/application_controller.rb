class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :main_layout

  before_action Proc.new{ authenticate_admin! if params[:controller] =~ /^admin/ }

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :qq, :email, :password, :password_confirmation, :remember_me) }
    # devise_parameter_sanitizer.for(:sign_up)<<:qq<<:name
    devise_parameter_sanitizer.for(:sign_in)<<:login
  end

  protected
    def main_layout
      if ['/admin/sign_in'].include?( request.path )
        false
      elsif params[:controller] =~ /^admin/
        'admin'
      else
        'application'
      end
    end

    def record_not_found
      flash[:error] = "数据操作错误: 请根据当前页面数据进行操作!"
      redirect_to :back
    end
end
