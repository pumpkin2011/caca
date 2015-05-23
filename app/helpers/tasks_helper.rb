module TasksHelper
  def task_level(task)
    case task.level
      when 'max'
        content_tag(:i, '', class: 'icon diamond blue')

      when 'one'
        content_tag(:i, '', class: 'icon heart red')

      when 'two'
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')

      when 'three'
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')
      when 'four'
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')
      when 'five'
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')+
        content_tag(:i, '', class: 'icon heart red')
      end
  end

  def task_type(task)
    if task.task_type == 'phone'
      content_tag(:i, '', class: 'icon tablet red')
    end
  end
end
