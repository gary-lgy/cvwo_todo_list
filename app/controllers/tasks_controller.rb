class TasksController < ApplicationController
  # get tasks by category
  def index
    @completed = current_user_tasks.completed.order(helpers.order)
    @ongoing = current_user_tasks.ongoing.order(helpers.order)
    helpers.add_reminder_for_urgent(@ongoing)
    helpers.add_alert_for_overdue(@ongoing)
  end

  # build new task
  def new
    @task = Task.new
  end

  # save newly built task
  def create
    @task = Task.new(task_params)
    if @task.save_new
      helpers.add_or_remove_tags(@task)
      flash[:success] = 'Task saved successfully.'
      redirect_to tasks_path
    else
      flash.now[:danger] = @task.errors.full_messages.join("\n")
      render 'new'
    end
  end

  # edit a task
  def edit
    @task = current_user_tasks.find(params[:id])
  end

  # save changes to a task
  def update
    @task = current_user_tasks.find(params[:id])
    if @task.update(task_params)
      helpers.add_or_remove_tags(@task)
      flash[:success] = 'Task updated successfully'
      redirect_to tasks_path
    else
      flash.now[:danger] = @task.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  # toggle between completed and incomplete
  def toggle_completed
    @task = current_user_tasks.find(params[:id])
    if @task.toggle_completed
      flash[:success] = '1 task completed'
    else
      flash[:info] = '1 task marked incomplete'
    end
    redirect_back fallback_location: tasks_path
  end

  # delete a task
  def destroy
    @task = current_user_tasks.find(params[:id])
    @task.destroy
    flash[:info] = 'Task deleted successfully'
    redirect_to tasks_path
  end

  private

  # allow only permitted parameters
  def task_params
    whitelisted = params.require(:task).permit(
      :title, :description, :deadline
    )
    params_in_utc = helpers.task_params_in_utc whitelisted
    helpers.append_user_id params_in_utc
  end

  # alias to the helper method
  def current_user_tasks
    helpers.current_user_tasks
  end

end
