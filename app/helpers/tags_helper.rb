module TagsHelper
  # add or remove tags as required
  def add_or_remove_tags(task)
    if params[:task][:tags].respond_to? 'each'
      params[:task][:tags].each do |tag|
        if Tag.exists?(name: tag[:name])
          if tag[:remove] == '1'
            task.tags.destroy(Tag.find_by(name: tag[:name]))
          elsif !task.tags.exists?(name: tag[:name])
            task.tags << Tag.find_by(name: tag[:name])
          end
        else
          task.tags.create name: tag[:name]
        end
      end
    end
  end

end
