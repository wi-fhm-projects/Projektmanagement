class DelphiController < ApplicationController
  def index
    @project = Project.find(params[:project])

  end
  def show
  end
  def create
    @quest = Questionarie.new(quest_params)
    @project = Project.find(quest_params[:project_id])
    respond_to do |format|
      if @quest.save
        format.html { redirect_to rbs_path(project: @project), success: 'Fragebogen wurde erfolgreich erstellt.' }
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
    @quest = Questionarie.new
  end

  private

    def find_quest
      @quest = Questionarie.find(params[:id])
    end

    def quest_params
      params.require(:questionarie).permit(:name, :description, :project_id)
    end
end
