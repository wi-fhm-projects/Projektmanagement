class RoleController < ApplicationController
  before_action :find_role, only: [:destroy]

  def index
    @roles = Roles.all
  end

  def show

  end

  def create
    @role = Role.new(role_params)
    @kind = Kind.find(role_params[:kind_id])
    @project = Project.find(@kind.project)
    respond_to do |format|
      if @role.save
        format.html { redirect_to rbs_path(project: @project), success: 'Rolle wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { redirect_to rbs_path(project: @project), danger: 'Rolle nicht erstellt' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @project = Project.find(params[:project])
    @role.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), success: 'Rolle wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @role = Role.new
  end

  private

    def find_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :qualifikation, :experience, :kind_id)
    end
end
