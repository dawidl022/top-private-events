class InvitationsController < ApplicationController
  def index
    unless user_signed_in?
      flash[:warning] = "Please sign in to see your invitations"
      redirect_to new_user_session_url
      return
    end

    @invitations = current_user.invitations
  end

  def create
  end

  def update
  end
end
