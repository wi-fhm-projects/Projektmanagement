class ResponseController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @questionary = Questionary.find(params[:questionary])
    @answer = Response.new()

  end
  def show
    @project = Project.find(params[:project])

  end
  def create
    @response = Response.new(resp_params)
    @question = Question.find(resp_params[:question_id])
    respond_to do |format|
      if @response.save
        calculate_average
        format.html { redirect_to response_index_path(project: @question.questionary.project,questionary: @question.questionary), success: 'Antwort wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), success: 'Fragebogen wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @project = Project.find(params[:project])
    @response = Question.new
  end

  private

    def find_response
      @response = Response.find(params[:id])
    end

    def resp_params
      params.require(:response).permit(:pessimistic,:realistic,:optimistic,:question_id)
    end

    def calculate_average
      anzahl = 0
      pess = 0
      opt = 0
      real = 0
      @question.responses.each do |resp|
        pess = pess + resp.pessimistic
        opt = opt + resp.optimistic
        real = real + resp.realistic
        anzahl = anzahl + 1
      end
      @question.pessimistic_average = pess/anzahl
      @question.optimistic_average = opt/anzahl
      @question.realistic_average = real/anzahl
      @question.save
    end
end
