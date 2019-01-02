class TasksController < ApplicationController
  # get tasks by category
  def index
    @archived = Task.archived.order(order)
    @ongoing = Task.ongoing.order(order)
  end

  private

  # sanitize and translate order parameter before using it
  def order
    if params[:order] == '2'
      'deadline ASC'
    elsif params[:order] == '3'
      'title ASC'
    else
      'created_at DESC'
    end
  end
end
