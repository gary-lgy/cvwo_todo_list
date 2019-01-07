class ApplicationController < ActionController::Base
  # check if the current user is recognized before doing anything else
  before_action :check_user_id_presence, except: :welcome

  # display welcome page and setup initial tasks and tags
  def welcome
    helpers.initial_setup
  end

  private

  # check if the current user is new by checking if the user_id cookie is set
  # if so, create a user_id for the current user and store it in a cookie
  def check_user_id_presence
    if helpers.user_id.nil?
      cookies.encrypted.permanent[:user_id] = SecureRandom.hex
      redirect_to welcome_path
    end
  end
end
