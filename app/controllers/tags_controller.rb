class TagsController < ApplicationController
  # TODO: implement tag renaming and creation with AJAX
  # list all tags
  def index
    @tags = current_user_tags.order(name: :asc)
  end

  # show all tasks associated with a tag
  def show
    @tag = current_user_tags.find_by(name: params[:name])
    @ongoing = @tag.tasks.ongoing.order(helpers.order)
    @completed = @tag.tasks.completed.order(helpers.order)
  end

  # destroy a tag (does not destroy associated tasks)
  def destroy
    @tag = current_user_tags.find_by(name: params[:name])
    @tag.destroy
    redirect_to tags_path
  end

  private

  # alias to the helper method
  def current_user_tags
    helpers.current_user_tags
  end
end
