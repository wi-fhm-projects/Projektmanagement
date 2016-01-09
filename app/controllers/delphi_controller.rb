class DelphiController < ApplicationController
  before_action :find_quest, only: [:destroy]

  def index
    @project = Project.find(params[:project])
    @newquest = Questionary.new()

  end
  def show
    @project = Project.find(params[:project])
    @questionary = Questionary.find(params[:questionary])

  end

  def create(project)
    @project = project
    last_quest_round = 0
    if @project.questionarys.last.present?
      last_quest_round = @project.questionarys.last.runde
    end
    last_quest_round = last_quest_round +1
    @quest = Questionary.new()
    @quest.runde = last_quest_round
    @quest.project_id = @project.id
    @quest.users << User.all
    respond_to do |format|
      if @quest.save
        project.tasks.each do |task|
          task.subtasks.each do |subtask|
            subtask.workpackages.each do |work|
              @question = Question.new()
              @question.workpackage_id = work.id
              @question.questionary_id = @quest.id
              @question.save
            end
          end
        end
        format.html { redirect_to delphi_index_path(project: @project), success: 'Fragebogen wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @project = @quest.project
    @quest.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), success: 'Fragebogen wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @project = Project.find(params[:project])
    create(@project)
  end

  private

    def find_quest
      @quest = Questionary.find(params[:id])
    end

    def quest_params
      params.require(:questionary).permit(:runde, :project_id)
    end
end
