class RoadmapsController < ApplicationController
  before_action :find_project, only: [:index, :new]

  def index

  end

  def show
    @roadmap = Roadmap.find(params[:id])
    @project = @roadmap.project
    roadmap_chart
  end

  def new
    @roadmap = Roadmap.new
    @questionaries = @project.questionarys
  end

  def create
    @roadmap = Roadmap.new(roadmap_params)
    @roadmap.title = 'Runde '+Questionary.find(roadmap_params[:questionary_id]).runde.to_s
    respond_to do |format|
      if @roadmap.save
        format.html { redirect_to @roadmap, success: 'Roadmap wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @roamap}
      else
        format.html { render :new }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  def find_project
    @project = Project.find(params[:project])
  end

  def roadmap_params
    params.require(:roadmap).permit(:title, :start, :questionary_id, :project_id)
  end

  def workpackages_array
    workpackages = Array.new
    @project.tasks.each do |task|
      task.subtasks.each do |stask|
        stask.workpackages.each do |work|
          workpackages.push(work)
        end
      end
    return workpackages
    end
  end

  def roadmap_chart
    @workpackages = workpackages_array

    def days_to_milli(days)
      days * 24 * 60 * 60 * 1000;
    end

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Task ID')
    data_table.new_column('string', 'Task Name')
    data_table.new_column('string', 'Resource')
    data_table.new_column('date'  , 'Start Date')
    data_table.new_column('date'  , 'End Date')
    data_table.new_column('number', 'Duration')
    data_table.new_column('number', 'Percent Complete')
    data_table.new_column('string', 'Dependencies')
    @workpackages.each do |work|
      @pre = ''
      work.predecessors.each do |p|
        @pre += p.id.to_s
        @pre += ", " unless work.predecessors.last.id == p.id
      end
      @date = nil
      @date = Date.new(@roadmap.start.year, @roadmap.start.month, @roadmap.start.day) unless work.predecessors.present?
      data_table.add_rows(
        [
          [work.id.to_s, work.name, nil, @date, nil, days_to_milli(@roadmap.questionary.questions.where(workpackage: work).first.realistic_average), 100 , @pre],
        ]
      )

    end
    opts   = { version: "1.1", height: 275 }
    @roadmap_chart = GoogleVisualr::Interactive::GanttChart.new(data_table, opts)
  end
end
