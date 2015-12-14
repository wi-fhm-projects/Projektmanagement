class ProjectsController < ApplicationController
  before_action :find_project, only: [:destroy, :show]

	def index
    @projects = Project.all
	end

  def show
    product_breakdown_chart
    roadmap_chart
  end


  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Projekt wurde erfolgreich erstellt.' }
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
      format.html { redirect_to projects_url, notice: 'Projekt wurde erfolgreich entfernt.' }
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

    def roadmap_chart
        data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'President' )
        data_table.new_column('date',   'Start'     )
        data_table.new_column('date',   'End'       )
        data_table.add_rows(
        [
          [ 'Projektentwurf', Date.new(2015, 12, 31), Date.new(2016, 2, 29) ],
          [ 'Feinplanung',      Date.new(2016, 2, 29),  Date.new(2016, 5, 30) ],
          [ 'Kundenpräsentation',  Date.new(2016, 4, 30),  Date.new(2016, 6, 30) ]
          ]
        )
        opts   = { :allowHtml => true }
        @rdm_chart = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
    end

end
