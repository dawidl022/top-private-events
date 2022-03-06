class EventAttendancesController < ApplicationController
  def create
    unless user_signed_in?
      flash[:warning] = "Please sign in to register for an event"
      redirect_to new_user_session_url
      return
    end

    unless params[:event] && (event = Event.find_by_id(params[:event]))
      flash[:error] = "Event not found"
      redirect_to root_url
      return
    end

    if current_user.attended_events.include?(event)
      flash[:success] = "You are already registered for this event"
      redirect_to event
      return
    end

    current_user.event_attendances.create(event_id: event.id)
    flash[:success] = "Successfully registered for the event!"
    redirect_to current_user
  end

  def destroy
    unless user_signed_in?
      flash[:warning] = "Please sign in to deregister from an event"
      redirect_to new_user_session_url
      return
    end

    unless params[:event]
      flash[:warning] = "Please choose event to deregister from"
      redirect_to current_user
      return
    end

    if (attendance = EventAttendance.find_by(
        attendee_id: current_user, event_id: params[:event]))
      attendance.destroy
      flash[:success] = "Successfully deregistered from the event."
      redirect_to current_user
    else
      flash[:error] = "Unable to find event"
    end
  end
end
