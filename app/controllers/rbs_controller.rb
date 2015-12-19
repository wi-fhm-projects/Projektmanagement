class RbsController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @kind = Kind.new
    @role = Role.new
    ressource_breakdown_chart
  end

  def show
    ressource_breakdown_chart
  end

  def create
    @kind = Kind.new(kind_params)
    @project = Project.find(kind_params[:project_id])
    respond_to do |format|
      if @kind.save
        format.html { redirect_to rbs_path(project: @project), success: 'Typ wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @kind.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), success: 'Typ wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @kind = Kind.new
  end

  private

    def find_kind
      @kind = Kind.find(params[:id])
    end

    def kind_params
      params.require(:kind).permit(:name, :project_id)
    end

    def ressource_breakdown_chart

      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      data_table.add_row(
        [
         {:v => "p"+@project.id.to_s, :f =>@project.title   }, "p"+@project.id.to_s, ' '
        ]
      )
      @project.kinds.each do |kind|
        data_table.add_row(
          [
            {:v => "k"+kind.id.to_s, :f =>kind.name   }, "p"+@project.id.to_s, ' '
          ]
        )
        kind.roles.each do |role|
          data_table.add_row(
            [
              {:v => "r"+role.id.to_s,
                :f =>'<div style="font-style:bold">'+ role.name+'</div>'+
                '<div style="font-style:italic">'+'Qualifikation:<br>'+role.qualifikation+'</div>'+
                '<div style="font-style:italic">'+'Erfahrung:<br>'+role.experience+'</div>'}, "k"+kind.id.to_s, ' '
            ]
          )
        end
      end
      opts   = { :allowHtml => true }
      @rbs_chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
    end
end
