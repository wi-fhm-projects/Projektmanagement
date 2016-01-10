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









  def calc_dates_pes

    # Fragebögen und Arbeitspakete holen
    @questionary = Questionary.find(@event.questionarys_id)
    @workpackages = Workpackage.all
    @eventdates = Eventdate.all

    @last_subtask_id
    @start_date = Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day)
    @last_date

    # Bevor es los geht, db cleanen
    @eventdates.delete_all

    #DB befüllen
    # Abchecken, ob workpackage vorhanden
    if @workpackages.any?
      @workpackages.each do |workpackage|
        #Kein neuer Subtask
        if @last_subtask_id == nil or @last_subtask_id == workpackage.id
          #Kein Vorgänger vorhanden!
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.pessimistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.pessimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.pessimistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.pessimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        else
          #Ab hier haben wir einen neuen Subtask
          @start_date = @last_date
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.pessimistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.pessimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.pessimistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.pessimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        end
      end
    end

  end



  def calc_dates_real

    # Fragebögen und Arbeitspakete holen
    @questionary = Questionary.find(@event.questionarys_id)
    @workpackages = Workpackage.all
    @eventdates = Eventdate.all

    @last_subtask_id
    @start_date = Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day)
    @last_date

    # Bevor es los geht, db cleanen
    @eventdates.delete_all

    #DB befüllen
    # Abchecken, ob workpackage vorhanden
    if @workpackages.any?
      @workpackages.each do |workpackage|
        #Kein neuer Subtask
        if @last_subtask_id == nil or @last_subtask_id == workpackage.id
          #Kein Vorgänger vorhanden!
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.realistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.realistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.realistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.realistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        else
          #Ab hier haben wir einen neuen Subtask
          @start_date = @last_date
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.realistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.realistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.realistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.realistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        end
      end
    end

  end


  def calc_dates_opt

    # Fragebögen und Arbeitspakete holen
    @questionary = Questionary.find(@event.questionarys_id)
    @workpackages = Workpackage.all
    @eventdates = Eventdate.all

    @last_subtask_id
    @start_date = Date.new(@event.startDate.year, @event.startDate.month, @event.startDate.day)
    @last_date

    # Bevor es los geht, db cleanen
    @eventdates.delete_all

    #DB befüllen
    # Abchecken, ob workpackage vorhanden
    if @workpackages.any?
      @workpackages.each do |workpackage|
        #Kein neuer Subtask
        if @last_subtask_id == nil or @last_subtask_id == workpackage.id
          #Kein Vorgänger vorhanden!
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.optimistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.optimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.optimistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.optimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        else
          #Ab hier haben wir einen neuen Subtask
          @start_date = @last_date
          if workpackage.successor_id == nil then
            @question = Question.find_by workpackage_id: workpackage.id
            #Frage muss ausgefüllt sein
            if @question.optimistic_average != nil
              startDate = @start_date
              endDate = @start_date + @question.optimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          else
            #Vorgänger vorhanden!
            #Frage muss ausgefüllt sein
            if @question.optimistic_average != nil
              # StartDate ist EndDate des Vorgänger (mit längster Dauer) und Enddate das StartDate des Vorgängers plus Frage
              startDate = @eventdates.order(:endDate).first.endDate
              endDate   = @eventdates.order(:endDate).first.endDate + @question.optimistic_average
              Eventdate.create(workpackage: workpackage, startDate: startDate, endDate: endDate)
              @last_subtask_id = workpackage.id
              @last_date = endDate
            end
          end
        end
      end
    end

  end




  def event_chart_pes
    #Daten erzeugen
    calc_dates_pes

    # Zum Schluss die Grafik erzeugen
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    if @eventdates.any?
      @eventdates.each do |eventdate|
        data_table.add_row([@workpackages.find(eventdate.workpackage_id).name, eventdate.startDate, eventdate.endDate])
      end
    end

    opts = {  allowHtml: true }
    @rdm_chart_pes = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end


  def event_chart_real
    #Daten erzeugen
    calc_dates_real

    # Zum Schluss die Grafik erzeugen
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    if @eventdates.any?
      @eventdates.each do |eventdate|
        data_table.add_row([@workpackages.find(eventdate.workpackage_id).name, eventdate.startDate, eventdate.endDate])
      end
    end

    opts = { allowHtml: true }
    @rdm_chart_real = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end


  def event_chart_opt
    #Daten erzeugen
    calc_dates_opt

    # Zum Schluss die Grafik erzeugen
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Arbeitspaket')
    data_table.new_column('date',   'Startzeitpunkt')
    data_table.new_column('date',   'Endzeitpunkt')

    if @eventdates.any?
      @eventdates.each do |eventdate|
        data_table.add_row([@workpackages.find(eventdate.workpackage_id).name, eventdate.startDate, eventdate.endDate])
      end
    end

    opts = { allowHtml: true }
    @rdm_chart_opt = GoogleVisualr::Interactive::Timeline.new(data_table, opts)
  end


end
