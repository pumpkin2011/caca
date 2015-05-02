class AuthenticatesController < ApplicationController

  # TODO: 图片上传及时预览
  # TODO: 支付宝帐号认证



  def edit
    current_user.identity || current_user.build_identity
    current_user.bank || current_user.build_bank
    # current_user.alipay || current_user.build_alipay
  end


  def update
    identity = Identity.find_or_initialize_by(user: current_user)
    identity.update( identity_params )

    bank = Bank.find_or_initialize_by(user: current_user)
    bank.update( bank_params )

    # alipay = Alipay.find_or_initialize_by(user: current_user)
    # alipay.update( alipay_params )

    redirect_to root_path


  end

  private
    def bank_params
      params.require(:user).require(:bank).permit(:name, :account, :deposit, :front)
    end

    def identity_params
      params.require(:user).require(:identity).permit(:name, :number, :front, :back, :handheld)
    end

    # def alipay_params
    #   params.require(:user).require(:alipay).permit(:name, :account)
    # end
end
