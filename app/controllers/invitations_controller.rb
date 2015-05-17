class InvitationsController < ApplicationController
  def index
    @invitation = current_user.invitations.page(params[:page])
  end
end
