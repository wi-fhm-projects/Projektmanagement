class ProjectsController < ApplicationController
	def index
    @projects = Project.all
	end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Produkt wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

 def new
    @project = Project.new
  end

  private
  
    def project_params
      params.require(:project).permit(:title, :description)
    end
end
