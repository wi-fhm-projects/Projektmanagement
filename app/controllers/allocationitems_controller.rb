class AllocationitemsController < ApplicationController
  before_action :find_allocationitem, only: [:destroy]

  def index
  end

  def show
  end

  def create
    @allocationItem = Allocationitem.new(allocation_params)
    @project = Project.find(@allocationItem.workpackage.subtask.task.project)
    respond_to do |format|
      if @allocationItem.save
        format.html { redirect_to ram_index_path(project: @project), success: 'Zuordnung wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to ram_path(project: @project), danger: 'Zuordnung nicht erstellt' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @project = Project.find(params[:project])
    @allocationItem.destroy
    respond_to do |format|
      format.html { redirect_to ram_index_path(project: @project), success: 'Zuordnung wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @allocationItem = Allocationitem.new
  end

  private

    def find_allocationitem
      @allocationItem = Allocationitem.find(params[:id])
    end

    def allocation_params
      params.require(:allocationitem).permit(:workpackage_id, :role_id, :component_id)
    end
end
