class TagsController < ApplicationController
  # TODO: implement tag renaming and deletion
  # list all tags
  def index
    @tags = Tag.order(name: :asc)
  end

  # show all tasks associated with a tag
  def show
    @tag = Tag.find_by(name: params[:name])
    @ongoing = @tag.tasks.ongoing.order(helpers.order)
    @archived = @tag.tasks.archived.order(helpers.order)
  end

end
