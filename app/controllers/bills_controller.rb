class BillsController < ApplicationController
  def show
    @bills = current_user.bills.page(params[:page])
  end
end
