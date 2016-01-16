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
    @roadmap.title = 'Auswertung zur Runde '+Questionary.find(roadmap_params[:questionary_id]).runde.to_s
    respond_to do |format|
      if @roadmap.save
        format.html { redirect_to roadmap_path(@roadmap, :type => 1), success: 'Roadmap wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @roamap}
      else
        format.html { redirect_to new_roadmap_path(project: @roadmap.project.id), danger: 'Startdatum muss angegeben werden' }
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
    @roadmap.questionary.questions.each do |q|
      workpackages.push(q.workpackage)
    end
    return workpackages

  end

  def roadmap_chart
    @workpackages = workpackages_array

    def days_to_milli(days)
      days * 24 * 60 * 60 * 1000;
    end

    real_table = GoogleVisualr::DataTable.new
    real_table.new_column('string', 'Task ID')
    real_table.new_column('string', 'Task Name')
    real_table.new_column('string', 'Resource')
    real_table.new_column('date'  , 'Start Date')
    real_table.new_column('date'  , 'End Date')
    real_table.new_column('number', 'Duration')
    real_table.new_column('number', 'Percent Complete')
    real_table.new_column('string', 'Dependencies')

    opt_table = GoogleVisualr::DataTable.new
    opt_table.new_column('string', 'Task ID')
    opt_table.new_column('string', 'Task Name')
    opt_table.new_column('string', 'Resource')
    opt_table.new_column('date'  , 'Start Date')
    opt_table.new_column('date'  , 'End Date')
    opt_table.new_column('number', 'Duration')
    opt_table.new_column('number', 'Percent Complete')
    opt_table.new_column('string', 'Dependencies')

    pess_table = GoogleVisualr::DataTable.new
    pess_table.new_column('string', 'Task ID')
    pess_table.new_column('string', 'Task Name')
    pess_table.new_column('string', 'Resource')
    pess_table.new_column('date'  , 'Start Date')
    pess_table.new_column('date'  , 'End Date')
    pess_table.new_column('number', 'Duration')
    pess_table.new_column('number', 'Percent Complete')
    pess_table.new_column('string', 'Dependencies')


    @workpackages.each do |work|
      @pre = ''
      work.predecessors.each do |p|
        @pre += p.id.to_s
        @pre += ", " unless work.predecessors.last.id == p.id
      end
      @date = nil
      @date = Date.new(@roadmap.start.year, @roadmap.start.month, @roadmap.start.day) unless work.predecessors.present?
      real_table.add_rows(
        [
          [work.id.to_s, work.subtask.name + '>' + work.name, nil, @date, nil, days_to_milli(@roadmap.questionary.questions.where(workpackage: work).first.realistic_average), 0 , @pre],
        ]
      )
      opt_table.add_rows(
        [
          [work.id.to_s, work.subtask.name + '>' + work.name, nil, @date, nil, days_to_milli(@roadmap.questionary.questions.where(workpackage: work).first.optimistic_average), 0 , @pre],
        ]
      )
      pess_table.add_rows(
        [
          [work.id.to_s, work.subtask.name + '>' + work.name, nil, @date, nil, days_to_milli(@roadmap.questionary.questions.where(workpackage: work).first.pessimistic_average), 0 , @pre],
        ]
      )

    end
    opts   = { version: "1.1", height: 275 }
    if params[:type] == '1'
      @real_chart = GoogleVisualr::Interactive::GanttChart.new(real_table, opts)
    end
    if params[:type] == '2'
      @opt_chart = GoogleVisualr::Interactive::GanttChart.new(opt_table, opts)
    end
    if params[:type] == '3'
      @pess_chart = GoogleVisualr::Interactive::GanttChart.new(pess_table, opts)
    end
  end
end
