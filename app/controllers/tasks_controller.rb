class TasksController < ApplicationController
  # get tasks by category
  def index
    @archived = Task.archived.order(order)
    @ongoing = Task.ongoing.order(order)
    add_reminder_for_urgent
    add_alert_for_overdue
  end

  private

  # sanitize and translate order parameter before using it
  def order
    if params[:order] == '2'
      'deadline ASC'
    elsif params[:order] == '3'
      'title ASC'
    else
      'created_at DESC'
    end
  end

  # count urgent tasks
  def urgent_count
    @ongoing.count &:urgent?
  end

  # count overdue tasks
  def overdue_count
    @ongoing.count &:overdue?
  end

  # add a flash reminder message if there are urgent tasks
  def add_reminder_for_urgent
    _urgent_count = urgent_count
    if _urgent_count.positive?
    flash.now[:reminder] = "#{_urgent_count}
      #{_urgent_count == 1 ? 'task is' : 'tasks are'}
      due within one day."
    end
  end

  # add a flash alert message if there are overdue tasks
  def add_alert_for_overdue
    _overdue_count = overdue_count
    if _overdue_count.positive?
      flash.now[:alert] = "#{_overdue_count}
      #{_overdue_count == 1 ? 'task is' : 'tasks are'}
      overdue"
    end
  end
end
