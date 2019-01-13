class ApplicationController < ActionController::Base
  # check if the current user is recognized before doing anything else
  before_action :check_user_id_presence

  private

  # check if the current user is new by checking if the user_id cookie is set
  # if so, create a user_id for the current user and store it in a cookie
  # also display the welcome page and setup initial tasks and tags
  def check_user_id_presence
    if helpers.user_id.nil?
      cookies.encrypted.permanent[:user_id] = SecureRandom.hex
      helpers.initial_setup
      render 'welcome'
    end
  end
end
