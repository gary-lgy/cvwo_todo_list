module LinkHelper
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

end