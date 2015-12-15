class RbsController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @kind = Kind.new
    @role = Role.new

  end

  def show

  end

  def create
    @kind = Kind.new(kind_params)

    respond_to do |format|
      if @kind.save
        format.html { redirect_to rbs_path(project: @project), notice: 'Typ wurde erfolgreich erstellt.' }
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
      format.html { redirect_to projects_url, notice: 'Typ wurde erfolgreich entfernt.' }
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
      params.require(:kind).permit(:name)
    end

    def ressource_breakdown_chart
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      data_table.add_rows(
        [
          [ {:v => 'Mike', :f => 'Mike<div style="color:red; font-style:italic">President</div>'   }, ''    , 'The President' ],
          [ {:v => 'Jim' , :f => 'Jim<div style="color:red; font-style:italic">Vice President<div>'}, 'Mike', 'VP'            ],
          [ 'Alice'  , 'Mike', ''           ],
          [ 'Bob'    , 'Jim' , 'Bob Sponge' ],
          [ 'Carol'  , 'Bob' , ''           ]
        ]
      )
      opts   = { :allowHtml => true }
      @pbs_chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
    end
end
