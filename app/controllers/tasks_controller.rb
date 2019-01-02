class TasksController < ApplicationController
  # get tasks by category
  def index
    @archived = Task.archived.order(order)
    @ongoing = Task.ongoing.order(order)
    add_reminder_for_urgent
    add_alert_for_overdue
  end

  # show details of a task
  def show
    @task = Task.find(params[:id])
  end

  # build new task
  def new
    @task = Task.new
  end

  # save newly built task
  def create
    @task = Task.new task_params
    @task.completed = false
    if @task.save
      flash[:notice] = 'Task saved successfully.'
      redirect_to @task
    else
      flash.now[:error] = @task.errors.full_messages.join("\n")
      render 'new'
    end
  end

  # edit a task
  def edit
    @task = Task.find(params[:id])
  end

  # save changes to a task
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'Task updated successfully'
      redirect_to @task
    else
      flash.now[:error] = @task.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  # delete a task
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  # allow only permitted parameters
  def task_params
    params.require(:task).permit(:title, :description, :deadline)
  end

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
