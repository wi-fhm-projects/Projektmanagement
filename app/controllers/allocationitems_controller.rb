class AllocationitemsController < ApplicationController

  def index
  end

  def show
  end

  def create
    @allocationItem = AllocationItem.new(allocation_params)
    @project = Project.find(@allocationItem.workpackage.project)
    respond_to do |format|
      if @role.save
        format.html { redirect_to ram_path(project: @project), success: 'Zuordnung wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to ram_path(project: @project), danger: 'Zuordnung nicht erstellt' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @allocationItem.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, success: 'Zuordnung wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @allocationItem = AllocationItem.new
  end

  private

    def find_role
      @role = Role.find(params[:id])
    end

    def allocation_params
      params.require(:allocationItem).permit(:workpackage_id, :role_id, :component_id)
    end
end
