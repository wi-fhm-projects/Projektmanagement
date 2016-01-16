class RequirmentController < ApplicationController
  before_action :find_req, only: [:destroy]

  def index
    @req = Requirment.all
  end

  def show

  end

  def create
    @req = Requirment.new(req_params)
    @role = Role.find(req_params[:role_id])
    @project = @role.kind.project
    respond_to do |format|
      if @req.save
        format.html { redirect_to rbs_path(project: @project), success: 'Anforderung wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to rbs_path(project: @project), danger: 'Anforderung nicht erstellt' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @project = Project.find(params[:project])
    @req.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), success: 'Anforderung wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @req = Requirment.new
  end

  private

    def find_req
      @req = Requirment.find(params[:id])
    end

    def req_params
      params.require(:requirment).permit(:qualifikation, :experience, :role_id)
    end
end
