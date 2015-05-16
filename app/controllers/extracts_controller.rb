class ExtractsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def create
    @extract = current_user.extracts.build(extract_param)
    respond_to do |format|
      if @extract.save
        format.js {}
        format.html{
          @extracts = current_user.extracts.page(params[:page])
          flash[:success] = "提现: #{number_to_currency(@extract.amount)} 成功。7个工作日内到账。"
          redirect_to :back
        }
      else
        format.js {}
        format.html{
          @extracts = current_user.extracts.page(params[:page])
          render :show
        }
      end
    end
  end

  def show
    @extract = Extract.new
    @extracts = current_user.extracts.page(params[:page])
  end

  private
    def extract_param
      params.require(:extract).permit(:amount)
    end
end
