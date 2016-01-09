class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  before_action :find_projects
  before_action :authenticate_user!

  def find_projects
    @projects = Project.all
  end

  def quest_count
    @quests = current_user.userquests.where(newquest: true)
    return @quests.count
  end
  helper_method :quest_count
end
