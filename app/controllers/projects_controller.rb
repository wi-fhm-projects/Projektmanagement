class ProjectsController < ApplicationController
	def index
    @projects = Project.all
	end

  def create
    @project = Project.new(project_params)
  end
end
