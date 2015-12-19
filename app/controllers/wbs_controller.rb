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
        format.html { redirect_to wbs_path(project: @project), success: 'Aufgabe wurde erfolgreich erstellt.' }
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
      format.html { redirect_to rbs_path(project: @project), success: 'Aufgabe wurde erfolgreich entfernt.' }
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
         {:v => "p"+@project.id.to_s, :f =>@project.title   }, "p"+@project.id.to_s, ' '
        ]
      )
      @project.tasks.each do |task|
        data_table.add_row(
          [
            {:v => "t"+task.id.to_s, :f =>task.name   }, "p"+@project.id.to_s, ' '
          ]
        )
        task.subtasks.each do |sub|
          data_table.add_row(
            [
              {:v => "s"+sub.id.to_s, :f =>sub.name   }, "t"+task.id.to_s, ' '
            ]
          )

          sub.workpackages.each do |work|
            data_table.add_row(
              [
                {:v => "w"+work.id.to_s, :f =>work.name   }, "s"+sub.id.to_s, ' '
              ]
            )
          end
        end
      end
      opts   = { :allowHtml => true }
      @wbs_chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
    end
end
