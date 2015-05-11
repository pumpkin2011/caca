class TemplatesController < ApplicationController

  def create
    @template = current_user.templates.build(
      name: params[:name],
      content: JSON.generate(task_param)
    )
    if @template.save
      render js: "alert('添加成功')"
    else

      render js: "alert('添加失败: #{@template.errors[:name].first}')"
    end
  end

  def index
    @templates = current_user.templates
  end

  def destroy
    @template = current_user.templates.find(params[:id])
    if @template.destroy
      flash[:succes] = "删除成功"
    else
      flash[:error] = '删除失败'
    end
    redirect_to templates_path
  end

  private
    def task_param
      params.require(:task).permit!
    end
end
