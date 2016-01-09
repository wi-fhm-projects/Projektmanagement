class QuestionController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @questionary = Questionary.find(params[:questionary])
    @quest = Question.new()
    selected_workpackages

  end
  def show
    @project = Project.find(params[:project])

  end
  def create()

    @quest = Question.new(quest_params)
    @questionary = Questionary.find(quest_params[:questionary_id])
    respond_to do |format|
      if @quest.save
        format.html { redirect_to question_index_path(project: @questionary.project,questionary: @questionary), success: 'Frage wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @quest.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), success: 'Fragebogen wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @project = Project.find(params[:project])
    @quest = Question.new
  end

  private

    def find_quest
      @quest = Question.find(params[:id])
    end

    def quest_params
      params.require(:question).permit(:frage, :workpackage_id, :questionary_id)
    end

    def selected_workpackages
      @packages = Array.new
      @project.tasks.each do |task|
        task.subtasks.each do |subtask|
          subtask.workpackages.each do |work|
            pack = [work.subtask.task.name+"/"+work.subtask.name+"/"+work.name,work.id]
            @packages.push(pack)
          end
        end
      end
    end
end
