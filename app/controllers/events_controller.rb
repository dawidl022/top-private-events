class EventsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_ownership, only: [:edit, :update, :destroy]

  def index
    @events = Event.visible
    @filter = event_filter || :all
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

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event details updated successfully!"
      redirect_to current_user
    else
      render :edit
    end
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created successfully!"
      redirect_to my_events_url
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event deleted successfully!"
    redirect_to current_user
  end

  private

    @@action_display_names = {
      new: "create", create: "create", edit: "edit", update: "edit",
      destroy: "delete"
    }

    def require_login
      unless user_signed_in?
        flash[:warning] =
          "Please sign in to #{@@action_display_names[action_name.to_sym]} events."
          redirect_to new_user_session_url
        return
      end
    end

    def require_ownership
      @event = Event.find_by_id(params[:id])

      unless @event.creator == current_user
        flash[:error] =
          "You cannot #{@@action_display_names[action_name.to_sym]} " \
          "events that someone else created"
        redirect_to root_url
      end
    end

    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time,
                                    :location, :private)
    end

    def event_filter
      if params[:filter] && Event.send(:valid_scope_name?, params[:filter])
        params[:filter]
      end
    end
end
