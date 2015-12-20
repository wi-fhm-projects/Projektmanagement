class ModulsController < ApplicationController
before_action :find_modul, only: [:destroy, :show]

def show
end

def create
  @project = Project.find(params.require(:modul)[:project_id])
  @modul = Modul.new(modul_params)

  respond_to do |format|
    if @modul.save
      format.html { redirect_to pbs_path(project: @project), success: 'Modul wurde erfolgreich erstellt.' }
      format.json { render :show, status: :created, location: @modul }
    else
      format.html { redirect_to pbs_path(project: @project), danger: 'Modul nicht erstellt' }
      format.json { render json: @modul.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @modul.destroy
  respond_to do |format|
    format.html { redirect_to moduls_url, success: 'Projekt wurde erfolgreich entfernt.' }
    format.json { head :no_content }
  end
end

def new
  @modul = Modul.new
end

def modul_params
  params.require(:modul).permit(:name, :description, :subproduct_id)
end

end
