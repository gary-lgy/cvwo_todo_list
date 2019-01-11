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

  # add a flash warning message if there are urgent tasks
  def add_reminder_for_urgent(tasks)
    urgent_count = count_urgent(tasks)
    if urgent_count.positive?
      flash.now[:warning] = "#{urgent_count}
        #{urgent_count == 1 ? 'task is' : 'tasks are'}
        due within one day."
    end
  end

  # add a flash danger message if there are overdue tasks
  def add_alert_for_overdue(tasks)
    overdue_count = count_overdue(tasks)
    if overdue_count.positive?
      flash.now[:danger] = "#{overdue_count}
        #{overdue_count == 1 ? 'task is' : 'tasks are'}
        overdue"
    end
  end

  # convert deadline as specified in params to UTC
  def task_params_in_utc(task_params)
    deadline = extract_time_from_params(task_params)
    { title: task_params[:title],
      description: task_params[:description],
      deadline: deadline }
  end

end
