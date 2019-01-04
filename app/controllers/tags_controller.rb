class TagsController < ApplicationController
  # TODO: implement tag renaming and deletion
  # TODO: add local variable names to partials and move shared partials to application folder
  # TODO: rewrite Back buttons (with JavaScript)?
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
