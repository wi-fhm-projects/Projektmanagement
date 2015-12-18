class WorkpackageController < ApplicationController
  def index
    @workpack = Workpackages.all
  end

  def show

  end

  def create
    @workpack = Workpackage.new(work_params)
    @subtask = Subtask.find(work_params[:subtask_id])
    @task = Task.find(@subtask.task)
    @project = Project.find(@task.project)
    respond_to do |format|
      if @workpack.save
        format.html { redirect_to wbs_path(project: @project), notice: 'Arbeitspacket wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @workpack.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Arbeitspacket wurde erfolgreich entfernt.' }
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

    def work_params
      params.require(:workpackage).permit(:name, :subtask_id)
    end
end
