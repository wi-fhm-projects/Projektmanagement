class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    find_project
    event_chart
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_event
        @event = Event.find(params[:id])
    end

    def find_project
      @project = Project.find(params[:project])
    end

    def event_params
      params.require(:event).permit(:title, :startDate, :endDate)
    end


    def event_chart
        data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'Event'         )
        data_table.new_column('date',   'Startzeitpunkt')
        data_table.new_column('date',   'Endzeitpunkt'  )

        if @events != nil then
        @events.each do |event|
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
