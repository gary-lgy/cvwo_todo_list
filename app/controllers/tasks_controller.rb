class TasksController < ApplicationController
  # get tasks by category
  def index
    @archived = current_user_tasks.archived.order(helpers.order)
    @ongoing = current_user_tasks.ongoing.order(helpers.order)
    helpers.add_reminder_for_urgent(@ongoing)
    helpers.add_alert_for_overdue(@ongoing)
  end

  # search for tasks with the given tags
  def search
    tag_names = params[:tag_names].split(' ')
    tasks = current_user_tasks.joins(:tags).where('tags.name' => tag_names)
    @ongoing = helpers.process_search_result tasks.ongoing
    @archived = helpers.process_search_result tasks.archived
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

  # toggle between completed and uncompleted
  def toggle_completed
    @task = current_user_tasks.find(params[:id])
    @task.toggle_completed
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
