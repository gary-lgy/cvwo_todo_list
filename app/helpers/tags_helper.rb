module TagsHelper
  # return all tags owned by the current user
  # user_id is retrieved from a cookie by the helper method user_id
  def current_user_tags
    Tag.where(user_id: user_id)
  end

  # add or remove tags as required
  def add_or_remove_tags(task)
    if params[:task][:tags].respond_to? 'each'
      params[:task][:tags].each do |tag|
        if tag[:status] == 'remove'
          task.tags.destroy(current_user_tags.find_by(name: tag[:name]))
          task.touch
        elsif tag[:status] == 'new' && tag[:name].present?
          new_tag = Tag.find_or_initialize_by name: tag[:name], user_id: task.user_id
          if new_tag.new_record?
            new_tag.save
            task.tags << new_tag
            task.touch
          elsif !task.tags.exists?(name: new_tag.name)
            task.tags << new_tag
            task.touch
          end
        end
      end
    end
  end

end
