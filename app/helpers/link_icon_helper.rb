# both link helpers and icon helper are here
# this is because some helpers generate links embedded in icons
module LinkIconHelper
  #########################################
  #---------- Link-only helpers ----------#
  #########################################
  # generate a link to dynamically add a tag when editing a task
  def link_to_add_tag
    fields = content_tag :div, class: 'tag' do
      text_field_tag 'task[tags][][name]'
    end
    link_to 'Add Tag',
            '#',
            id: 'add_tag',
            data: { fields: fields.delete("\n") }
  end

  # generate a link to tags#index
  def link_to_tags_path
    link_to 'Manage Tags', tags_path
  end

  # generate a link to delete tags
  def link_to_delete_tag(tag, display)
    link_to display,
            tag_path(tag),
            method: :delete,
            data: { confirm: 'Sure to delete this tag? '\
              'This does not delete its tasks. ' }
  end

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
        icon 'far', 'check-circle', class: 'action-icon'
      else
        icon 'far', 'circle', class: 'action-icon'
      end
    end
  end

  # generate a link to a tag, presented on a button
  def tag_button(tag)
    link_to tag.name,
            '#',
            class: 'tag badge font-italic'
  end

  # generate a link to edit a task, presented on an icon
  def edit_task_icon(task)
    link_to edit_task_path(task) do
      icon 'fas', 'edit', class: 'action-icon'
    end
  end

  # generate a link to delete a task, presented on an icon
  def destroy_task_icon(task)
    link_to task_path(task),
            method: :delete,
            data: { confirm: 'Are you sure?' } do
      icon 'far', 'trash-alt', class: 'action-icon'
    end
  end

end