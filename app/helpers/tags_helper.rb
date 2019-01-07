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
        if current_user_tags.exists?(name: tag[:name])
          if tag[:remove] == '1'
            task.tags.destroy(current_user_tags.find_by(name: tag[:name]))
          elsif !task.tags.exists?(name: tag[:name])
            task.tags << current_user_tags.find_by(name: tag[:name])
          end
        else
          task.tags.create name: tag[:name], user_id: task.user_id
        end
      end
    end
  end

end
