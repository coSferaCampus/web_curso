class MainController < ApplicationController
  before_action :authenticate_user!
  before_action :share_with_gon

  def index
    render text: '', layout: 'application'
  end

  private

  def share_with_gon
    gon.currentUser = current_user
    gon.currentUserId = current_user.id.to_s if current_user
  end
end
