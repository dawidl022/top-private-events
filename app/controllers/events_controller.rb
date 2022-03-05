class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by_id(params[:id])

    unless @event
      flash[:error] = "Event not found"
      redirect_to root_url
    end
  end

  def new
    @event = Event.new
  end

  def create
    unless user_signed_in?
      flash[:warning] = "Please sign in to post an event."
      redirect_to new_user_session_url
      return
    end

    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created successfully!"
      redirect_to my_events_url
    else
      render :new
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time,
                                    :location)
    end
end
