class WbsController < ApplicationController
  def index
    @project = Project.find(params[:project])
    @task = Task.new
    @subtask = Subtask.new
    @workpack = Workpackage.new
    work_breakdown_chart

  end

  def show
  end

  def create
    @task = Task.new(task_params)
    @project = Project.find(task_params[:project_id])
    respond_to do |format|
      if @task.save
        format.html { redirect_to wbs_path(project: @project), notice: 'Aufgabe wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @kind}
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to rbs_path(project: @project), notice: 'Aufgabe wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @task = Task.new
  end

  private

    def find_kind
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :project_id)
    end

    def work_breakdown_chart

      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      data_table.add_row(
        [
         {:v => @project.title, :f =>@project.title   }, @project.title, ' '
        ]
      )
      @project.tasks.each do |task|
        data_table.add_row(
          [
            {:v => task.name, :f =>task.name   }, @project.title, ' '
          ]
        )
        task.subtasks.each do |sub|
          data_table.add_row(
            [
              {:v => sub.name, :f =>sub.name   }, task.name, ' '
            ]
          )

          sub.workpackages.each do |work|
            data_table.add_row(
              [
                {:v => work.name, :f =>work.name   }, sub.name, ' '
              ]
            )
          end
        end
      end
      opts   = { :allowHtml => true }
      @wbs_chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
    end
end
