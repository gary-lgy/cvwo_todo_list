module TasksHelper
  # add a flash reminder message if there are urgent tasks
  def add_reminder_for_urgent
    _urgent_count = Task.count_urgent
    if _urgent_count.positive?
      flash.now[:reminder] = "#{_urgent_count}
      #{_urgent_count == 1 ? 'task is' : 'tasks are'}
      due within one day."
    end
  end

  # add a flash alert message if there are overdue tasks
  def add_alert_for_overdue
    _overdue_count = Task.count_overdue
    if _overdue_count.positive?
      flash.now[:alert] = "#{_overdue_count}
      #{_overdue_count == 1 ? 'task is' : 'tasks are'}
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
end
