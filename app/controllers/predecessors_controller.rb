class PredecessorsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @pred = Predecessor.new()
    respond_to do |format|
      if @pred.save
        format.html { redirect_to wbs_path(project: @project), success: 'Vorgänger wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to wbs_path(project: @project), danger: 'Vorgänger nicht erstellt' }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pred.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, success: 'Vorgänger wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @pred = Predecessor.new
  end
end
