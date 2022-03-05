class UsersController < ApplicationController
  def show
    if params[:id]
      unless (@user = User.find_by_id(params[:id]))
        flash[:error] = "Non-existent user"
        redirect_to root_url
      end
    elsif user_signed_in?
      @user = current_user
    else
      flash[:warning] = "Please sign in to see your events"
      redirect_to root_url
    end

    @events = @user&.events
  end
end
