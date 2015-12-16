class ProjectsController < ApplicationController
  before_action :find_project, only: [:destroy, :show]

	def index
    @projects = Project.all
	end

  def show
    @product = Subproduct.new
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Projekt wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Projekt wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @project = Project.new
  end

  private

    def find_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:title, :description)
    end
end
