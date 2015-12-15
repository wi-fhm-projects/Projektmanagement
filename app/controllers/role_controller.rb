class RoleController < ApplicationController
  def index
    @roles = Roles.all
  end

  def show

  end

  def create
    @role = Role.new(role_params)
    @project = Project.find(kind_params[:project_id])
    respond_to do |format|
      if @project.save
        format.html { redirect_to rbs_path(project: @project), notice: 'Rolle wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Rolle wurde erfolgreich entfernt.' }
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
      params.require(:role).permit(:name, :qualifikation, :experience, :project_id)
    end
end
