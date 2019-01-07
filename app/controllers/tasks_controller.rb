class TasksController < ApplicationController
  # TODO: store user_id in a cookie
  # get tasks by category
  def index
    @archived = Task.archived.order(helpers.order)
    @ongoing = Task.ongoing.order(helpers.order)
    helpers.add_reminder_for_urgent
    helpers.add_alert_for_overdue
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
    @task = Task.new(task_params)
    if @task.save_new
      helpers.add_or_remove_tags(@task)
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
      helpers.add_or_remove_tags(@task)
      flash[:notice] = 'Task updated successfully'
      redirect_to @task
    else
      flash.now[:error] = @task.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  # toggle between completed and uncompleted
  def toggle_completed
    @task = Task.find(params[:id])
    @task.toggle_completed
    redirect_back fallback_location: tasks_path
  end

  # delete a task
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task deleted successfully'
    redirect_to tasks_path
  end

  private

  # allow only permitted parameters
  def task_params
    whitelisted = params.require(:task).permit(
      :title, :description, :deadline
    )
    helpers.task_params_in_utc whitelisted
  end

end
