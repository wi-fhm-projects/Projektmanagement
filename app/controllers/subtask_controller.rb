class SubtaskController < ApplicationController
  before_action :find_subtask, only: [:destroy]
   def index
    @subtasks = Subtasks.all
  end

  def show

  end

  def create
    @subtask = Subtask.new(sub_params)
    @task = Task.find(sub_params[:task_id])
    @project = Project.find(@task.project)
    respond_to do |format|
      if @subtask.save
        format.html { redirect_to wbs_path(project: @project), success: 'Teilaufgabe wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to wbs_path(project: @project), danger: 'Teilaufgabe nicht erstellt' }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @project = Project.find(params[:project])
    @subtask.destroy
    respond_to do |format|
      format.html { redirect_to wbs_path(project: @project), success: 'Teilaufgabe wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @subtask = Subtask.new
  end

  private

    def find_subtask
      @subtask = Subtask.find(params[:id])
    end

    def sub_params
      params.require(:subtask).permit(:name, :task_id)
    end
end
