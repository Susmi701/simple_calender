class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @start_date = params[:start_date] ? Date.parse(params[:start_date]).beginning_of_month : Date.today.beginning_of_month
    end_date =@start_date.end_of_month.end_of_day
    @events = Event.where(start_date: @start_date..end_date).load_async
    @daily_events = @events.where(start_date: Date.today.beginning_of_day..Date.today.end_of_day).load_async
  end
  
  def timeline
    @date = params[:selected_date] ? Date.parse(params[:selected_date]) : Date.today
    @daily_events = Event.where(start_date: @date.beginning_of_day..@date.end_of_day)
    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "event_timeline",
          partial: "timeline",
          locals: { daily_events: @daily_events }
        )
      end
    end
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date)
    end
end
