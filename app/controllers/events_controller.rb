class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.new
    find_project
    event_chart
  end

  def show
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

    if @event.number == nil then
      @event.number = 1
    end
    if @event.title == nil then
      @event.title = "Titel"
    end
    if @event.startDate == nil then
      @event.startDate = DateTime.now
    end
    if @event.endDate == nil then
      @event.endDate = DateTime.now + 90
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to  events_path(project: @project), notice: 'Event was successfully created.' }
        format.json { render :index, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    find_event
    find_project

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
      params.require(:event).permit(:number, :title, :startDate, :endDate, :project_id)
    end

    def event_chart
        data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'Event'         )
        data_table.new_column('date',   'Startzeitpunkt')
        data_table.new_column('date',   'Endzeitpunkt'  )

        if @project.events.any? then
        @project.events.each do |event|
          data_table.add_row(
          [
            event.title, Date.new(event.startDate.year, event.startDate.month, event.startDate.day), Date.new(event.endDate.year, event.endDate.month, event.endDate.day)
          ]
          )
          end
        end

        opts   = { :allowHtml => true }
        @rdm_chart = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
    end
end
