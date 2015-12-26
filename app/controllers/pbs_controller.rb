class PbsController < ApplicationController
before_action :find_project, only: [:destroy, :show]

def index
	@project = Project.find(params[:project])
  @subproduct = Subproduct.new
  @modul = Modul.new
  @component = Component.new
  product_breakdown_chart
end

def show
  @product = Subproduct.new
  product_breakdown_chart
end

def create
  @project = Project.new(project_params)

  respond_to do |format|
    if @project.save
      format.html { redirect_to projects_path, success: 'Projekt wurde erfolgreich erstellt.' }
      format.json { render :show, status: :created, location: @project }
    else
      format.html { render :new }
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @project.destroy
  respond_to do |format|
    format.html { redirect_to projects_url, success: 'Projekt wurde erfolgreich entfernt.' }
    format.json { head :no_content }
  end
end

def new
  @project = Project.new
end

private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def product_breakdown_chart
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      data_table.add_row(
        [
         {:v => "p"+@project.id.to_s, :f =>@project.title   }, "p"+@project.id.to_s, ' '
        ]
      )
      @project.subproducts.each do |subproduct|
        data_table.add_row(
          [
            {:v => "s"+subproduct.id.to_s, :f =>subproduct.name   }, "p"+@project.id.to_s, ' '
          ]
        )
        subproduct.moduls.each do |modul|
          data_table.add_row(
            [
              {:v => "m"+modul.id.to_s, :f =>modul.name   }, "s"+subproduct.id.to_s, ' '
            ]
          )

          modul.components.each do |component|
            data_table.add_row(
              [
                {:v => "c"+component.id.to_s, :f =>component.name   }, "m"+modul.id.to_s, ' '
              ]
            )
          end
        end
      end
    opts   = { :allowHtml => true }
    @pbs_chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
  end
end
