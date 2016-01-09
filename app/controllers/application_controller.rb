class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  before_action :find_projects
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def find_projects
    @projects = Project.all
  end

  def quest_count
    @quests = current_user.userquests.where(newquest: true)
    return @quests.count
  end
  helper_method :quest_count


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit [:first_name, :last_name, :email, :password, :password_confirmation] }
  end
end
