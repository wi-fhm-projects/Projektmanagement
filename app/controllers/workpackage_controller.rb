class WorkpackageController < ApplicationController
  def index
    @workpack = Workpackages.all
  end

  def show

  end

  def create
    @pre = params.require(:workpackage)[:successor]
    @workpack = Workpackage.new(work_params)
    @pre.each do |pre|
      @package = Workpackage.find(pre) unless pre.blank?
      @workpack.predecessors << @package unless @package.blank?
    end

    @subtask = Subtask.find(work_params[:subtask_id])
    @task = Task.find(@subtask.task)
    @project = Project.find(@task.project)
    respond_to do |format|
      if @workpack.save

        format.html { redirect_to wbs_path(project: @project), success: 'Arbeitspaket wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to wbs_path(project: @project), danger: 'Arbeitspaket nicht erstellt' }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @workpack.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, success: 'Arbeitspacket wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @workpack = Workpackage.new
  end

  private

    def find_workpackage
      @workpack = Workpackage.find(params[:id])
    end

    def successor
      @predecessors = params[:successor]
    end

    def work_params
      successor
      params.require(:workpackage).permit(:name, :subtask_id)
    end
end
