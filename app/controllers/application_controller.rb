class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :main_layout
  before_action Proc.new{ authenticate_admin! if params[:controller] =~ /^admin/ }

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
end
