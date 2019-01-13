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

  # generate reminders for urgent tasks to display in views
  def reminder_for_urgent_tasks(tasks)
    urgent_count = count_urgent(tasks)
    if urgent_count.positive?
        urgent_icon +
        (content_tag :span, urgent_count,
                    class: 'badge badge-warning ml-1')
    else
      ''
    end
  end

  # generate alerts for overdue tasks to display in views
  def alert_for_overdue_tasks(tasks)
    overdue_count = count_overdue(tasks)
    if overdue_count.positive?
        overdue_icon +
        (content_tag :span, overdue_count,
                    class: 'badge badge-danger ml-1')
    else
      ''
    end
  end

end
