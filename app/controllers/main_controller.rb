class MainController < ApplicationController
  before_action :authenticate_user!

  def index
    render text: '', layout: 'application'
  end
end
