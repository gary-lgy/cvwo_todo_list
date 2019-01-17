# both link helpers and icon helper are here
# this is because some helpers generate links embedded in icons
module LinkIconHelper
  #########################################
  #---------- Link-only helpers ----------#
  #########################################
  # generate a link to tasks#index
  def link_to_tasks_path
    link_to 'Back to Tasks', tasks_path
  end

  #########################################
  #---------- Icon-only helpers ----------#
  #########################################
  def urgent_icon
    icon 'fas', 'hourglass-half', class: 'status-icon-reminder'
  end

  def overdue_icon
    icon 'far', 'calendar-times', class: 'status-icon-warning'
  end

  def description_icon
    icon 'fas', 'align-left', class: 'details-icon'
  end

  def deadline_icon
    icon 'fas', 'calendar-day', class: 'details-icon'
  end

  def tag_icon
    icon 'fas', 'tags', class: 'details-icon'
  end

  ############################################
  #---------- Link-on-icon helpers ----------#
  ############################################
  # link to complete / un-complete a task, presented on a icon
  # depending on whether the task is completed, the icon will
  # be an empty circle or a ticked circle
  def toggle_complete_icon(task)
    link_to toggle_completed_task_path(task) do
      if task.completed?
        icon 'far', 'check-circle', class: 'checkbox-icon'
      else
        icon 'far', 'circle', class: 'checkbox-icon'
      end
    end
  end

  # generate a link to a tag, presented on a button
  def tag_with_link(tag_name)
    link_to tag_name,
            '#',
            class: 'tag badge font-italic'
  end

  # generate a tag, without a link on it
  def tag_without_link(tag_name)
    content_tag :div, tag_name,
                class: 'tag badge font-italic'
  end

  # generate a link to edit a task, presented on an icon
  def edit_task_icon(task)
    link_to edit_task_path(task) do
      icon 'fas', 'edit', class: 'edit-icon'
    end
  end

  # generate a link to delete a task, presented on an icon
  def destroy_task_icon(task)
    link_to task_path(task),
            method: :delete,
            data: { confirm: 'Are you sure?' } do
      icon 'far', 'trash-alt', class: 'delete-icon'
    end
  end

end