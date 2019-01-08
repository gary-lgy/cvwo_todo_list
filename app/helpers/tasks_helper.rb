module TasksHelper
  # return all tasks owned by the current user
  # user_id is retrieved from a cookie by the helper method user_id
  def current_user_tasks
    Task.where(user_id: user_id)
  end

  # count urgent tasks
  def count_urgent(tasks)
    tasks.count &:urgent?
  end

  # count overdue tasks
  def count_overdue(tasks)
    tasks.count &:overdue?
  end

  # add a flash reminder message if there are urgent tasks
  def add_reminder_for_urgent(tasks)
    urgent_count = count_urgent(tasks)
    if urgent_count.positive?
      flash.now[:reminder] = "#{urgent_count}
        #{urgent_count == 1 ? 'task is' : 'tasks are'}
        due within one day."
    end
  end

  # add a flash alert message if there are overdue tasks
  def add_alert_for_overdue(tasks)
    overdue_count = count_overdue(tasks)
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

  # read order from params, sanitize it and
  # store it in a permanent cookie
  def set_order_cookie
    cookies.permanent[:order] =
      params[:order]&.match(/[23]/) ? params[:order] : '1'
  end

  # translate order cookie into sql fragment
  def order_in_sql
    case cookies[:order]
    when '2'
      'deadline ASC'
    when '3'
      'title ASC'
    else
      'created_at DESC'
    end
  end

  # convert deadline as specified in params to UTC
  def task_params_in_utc(task_params)
    deadline = extract_time_from_params(task_params)
    { title: task_params[:title],
      description: task_params[:description],
      deadline: deadline }
  end

  # sort search result (with duplicates) by the number of
  # times each record appears in the result
  # and remove duplicates
  def process_search_result(tasks)
    relevance_count = Hash.new 0
    tasks.each do |task|
      relevance_count[task] += 1
    end
    tasks.uniq.sort_by { |task| -relevance_count[task] }
  end

end
