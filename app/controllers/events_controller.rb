class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.new
    find_project
  end

  def show
    @project = Project.find(@event.project_id)
    event_chart_pes
    event_chart_real
    event_chart_opt
  end

  def new
    find_project
    @event = Event.new
    @events = Event.all
  end

  def edit
    find_project
    find_event
  end

  def create
    @event = Event.new(event_params)
    find_project_by_id

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path(project: @project), notice: 'Event was successfully created.' }
        format.json { render :index, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    find_event
    # find_project

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path(project: @project), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project])
  end

  def find_project_by_id
    @project = Project.find(event_params[:project_id])
  end

  def set_project
    @project = project
  end

  def get_project
    @project
  end

  def event_params
    params.require(:event).permit(:startDate, :project_id, :questionarys_id)
  end

  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #

  def event_chart_pes
    @questionary = Questionary.find(@event.questionarys_id)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    @workpackages = Workpackage.all
    @workpackages.each do |workpackage|
      @last

      if workpackage.predecessors.empty?
        @question = Question.find_by workpackage_id: workpackage.id   #Frage suchen, die die Dauer des Arbeitspaket enthält
        if @question != nil and @question.pessimistic_average != nil then                     #Nicht weitermachen, wenn noch keine Dauer angegeben wurde
          data_table.add_row(
            [workpackage.name, Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day),
             (Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + @question.pessimistic_average)]
          )
        end
      else
        @question = Question.find_by workpackage_id: workpackage.id
        @max = 0
        if @question != nil and @question.pessimistic_average != nil then
          workpackage.predecessors.each do |pre|
            @preQuestion = Question.find_by workpackage_id: pre.id
            if @max < @preQuestion.pessimistic_average
              @max = @preQuestion.pessimistic_average
            end

            if @last.nil?
              data_table.add_row(
                [workpackage.name, (Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + @max),
                 (Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + @max + @question.pessimistic_average)]
              )
              @last = Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + @max + @question.pessimistic_average
            else
              data_table.add_row(
                [workpackage.name, @last,
                 (@last + @question.pessimistic_average)]
              )
            end
          end
        end
       end
    end

    opts = { width: 900, height: 900, allowHtml: true }
    @rdm_chart_pes = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end

  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #

  def event_chart_real
    @questionary = Questionary.find(@event.questionarys_id)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    @workpackages = Workpackage.all
    @workpackages.each do |workpackage|
      @question = Question.find_by workpackage_id: workpackage.id
      data_table.add_row(
        [workpackage.name, Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day),
         (Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + 90)]
      )
    end

    opts = { width: 900, allowHtml: true }
    @rdm_chart_real = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end

  def event_chart_opt
    @questionary = Questionary.find(@event.questionarys_id)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    @questionary.questions.each do |question|
      @workpackage = Workpackage.find(question.workpackage_id)
      data_table.add_row(
        [@workpackage.name, Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day),
         (Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day) + 90)]
      )
    end

    opts = { width: 900, allowHtml: true }
    @rdm_chart_opt = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end
end
