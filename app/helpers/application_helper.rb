module ApplicationHelper
  # append a new query string to a url
  def append_query_string_to_url(url, name, value)
    if url.include? '?'
      "#{url}&#{name}=#{value}"
    else
      "#{url}?#{name}=#{value}"
    end
  end

  # read and return the current user_id from cookies
  def user_id
    cookies.encrypted[:user_id]
  end

  # append user_id to params
  def append_user_id(params)
    params[:user_id] = user_id
    params
  end

  # create initial tasks and tags for a new user
  def initial_setup
    user_id = user_id()
    tag = Tag.create name: 'learning', user_id: user_id
    # create an completed task
    tag.tasks.create title: 'completed tasks will be shown here',
                     user_id: user_id,
                     completed: true
    # create an urgent task
    tag.tasks.create title: 'tasks due in one day will be marked urgent',
                     user_id: user_id,
                     completed: false,
                     deadline: 6.hours.from_now.at_beginning_of_hour
    # create a normal task
    tag.tasks.create title: 'tick the circle to complete this task',
                     user_id: user_id,
                     completed: false
  end

end
