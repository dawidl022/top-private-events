class EventAttendancesController < ApplicationController
  def create
    unless user_signed_in?
      flash[:warning] = "Please sign in to register for an event"
      redirect_to new_user_session_url
      return
    end

    unless params[:event_id] && Event.find_by_id(params[:event_id])
      flash[:error] = "Event not found"
      redirect_to root_url
      return
    end

    current_user.event_attendances.create(event_id: params[:event_id])
    flash[:success] = "Successfully registered for the event!"
    redirect_to current_user
  end
end
