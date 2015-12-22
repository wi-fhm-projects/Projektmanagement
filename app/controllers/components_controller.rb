class ComponentsController < ApplicationController
before_action :find_component, only: [:destroy, :show]

def show
end

def create
  @project = Project.find(params.require(:component)[:project_id])
  @component = Component.new(component_params)

  respond_to do |format|
    if @component.save
      format.html { redirect_to pbs_path(project: @project), success: 'Komponente wurde erfolgreich erstellt.' }
      format.json { render :show, status: :created, location: @component }
    else
      format.html { redirect_to pbs_path(project: @project), danger: 'Kompnente nicht erstellt' }
      format.json { render json: @component.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @project = @component.modul.subproduct.project
  @component.destroy
  respond_to do |format|
    format.html { redirect_to pbs_path(project: @project), success: 'Komponente wurde erfolgreich entfernt.' }
    format.json { head :no_content }
  end
end

def new
  @component = Component.new
end

def component_params
  params.require(:component).permit(:name, :description, :modul_id)
end

  def find_component
    @component = Component.find(params[:id])
  end
end
