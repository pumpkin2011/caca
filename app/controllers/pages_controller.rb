class PagesController < ApplicationController
  before_action Proc.new{
    @categories = PageCategory.includes(:pages).all
  }
  def index

  end

  def show
    @page = Page.find_by_code(params[:id])
  end
end
