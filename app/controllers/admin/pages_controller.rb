class Admin::PagesController < ApplicationController
  before_action :category, only: [:new, :edit]

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_param)
    if @page.save
      flash[:success] = '添加成功'
      redirect_to admin_pages_path
    else
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_param)
      flash[:success] = '编辑成功'
      redirect_to admin_pages_path
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:success] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to admin_pages_path
  end

  private
    def page_param
      params.require(:page).permit(:name, :code, :content, :category_id)
    end

    def category
      @categories = PageCategory.all
    end
end
