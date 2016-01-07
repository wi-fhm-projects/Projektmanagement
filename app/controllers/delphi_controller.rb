class DelphiController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @newquest = Questionary.new()

  end
  def show
    @project = Project.find(params[:project])
    @questionary = Questionary.find(params[:questionary])

  end
  def create
    @project = Project.find(params[:project_id])
    last = 0
    if @project.questionarys.present?
      last = @project.questionarys.last.round
    end
    @quest = Questionary.new(last + 1,@project.id)

    respond_to do |format|
      if @quest.save
        format.html { redirect_to delphi_index_path(project: @project), success: 'Fragebogen wurde erfolgreich erstellt.' }
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
    @quest = Questionary.new
  end

  private

    def find_quest
      @quest = Questionarie.find(params[:id])
    end

    def quest_params
      params.require(:questionary).permit(:name, :project_id)
    end
end
