module TasksHelper
  # add a flash reminder message if there are urgent tasks
  def add_reminder_for_urgent
    urgent_count = Task.count_urgent
    if urgent_count.positive?
      flash.now[:reminder] = "#{urgent_count}
        #{urgent_count == 1 ? 'task is' : 'tasks are'}
        due within one day."
    end
  end

  # add a flash alert message if there are overdue tasks
  def add_alert_for_overdue
    overdue_count = Task.count_overdue
    if overdue_count.positive?
      flash.now[:alert] = "#{overdue_count}
        #{overdue_count == 1 ? 'task is' : 'tasks are'}
        overdue"
    end
  end

  # change order stored in the cookies if needed
  # and return the new order
  def order
    set_order_cookie
    order_in_sql
  end

  # change order cookie if needed
  def set_order_cookie
    cookies[:order] = params[:order] unless params[:order].nil?
  end

  # read order from cookies, sanitize it and
  # translate it into sql fragment
  def order_in_sql
    if cookies[:order] == '2'
      'deadline ASC'
    elsif cookies[:order] == '3'
      'title ASC'
    else
      'created_at DESC'
    end
  end

  # generate a link to dynamically add a tag when editing a task
  def link_to_add_tag
    fields = content_tag :div, class: 'tag' do
      text_field_tag 'task[tags][][name]'
    end
    link_to 'Add Tag',
            '#',
            id: 'add_tag',
            data: { fields: fields.delete("\n") }
  end

  # add or remove tags as required
  def add_or_remove_tags
    params[:task][:tags].each do |tag|
      if Tag.exists?(name: tag[:name])
        if tag[:remove] == '1'
          @task.tags.destroy(Tag.find_by(name: tag[:name]))
        elsif !@task.tags.exists?(name: tag[:name])
          @task.tags << Tag.find_by(name: tag[:name])
        end
      else
        @task.tags.create name: tag[:name]
      end
    end
  end

end
