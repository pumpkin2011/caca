class AuthenticatesController < ApplicationController

  # TODO: 图片上传及时预览
  # TODO: 支付宝帐号认证



  def edit
    current_user.build_identity
    current_user.build_bank
  end

  def update
    unless ['confirmed', 'officialed'].include?(current_user.state)
        if current_user.update(auth_params)
          current_user.update(state: 'pending')
          flash[:success] = '资料更新成功'
        else
          render :edit
          return
        end
    else
        flash[:error] = '已认证资料不能修改'
    end
    redirect_to root_path
  end

  private
    def auth_params

      params.require(:user).permit(
          bank_attributes: [:name, :account, :deposit],
          identity_attributes: [:name, :number, :front, :back, :handheld]
      )
    end
end
