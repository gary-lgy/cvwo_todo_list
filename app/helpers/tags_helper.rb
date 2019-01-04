module TagsHelper
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

  # add or remove tags as required
  def add_or_remove_tags
    if params[:task][:tags].respond_to? 'each'
      params[:task][:tags].each do |tag|
        if Tag.exists?(name: tag[:name])
          if tag[:remove] == '1'
            @task.tags.destroy(Tag.find_by(name: tag[:name]))
          elsif !@task.tags.exists?(name: tag[:name])
            @task.tags << Tag.find_by(name: tag[:name])
          end
        else
          @task.tags.create name: tag[:name]
        end
      end
    end
  end

  # generate a link to tags#index
  def link_to_tags_path
    link_to 'Manage Tags', tags_path
  end

end
