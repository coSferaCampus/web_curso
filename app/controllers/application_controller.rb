class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :determine_template, only: [ :show, :create, :index, :update, :destroy ]

  self.responder = ActsAsApi::Responder

  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404
  rescue_from Mongoid::Errors::InvalidFind, with: :render_404
  rescue_from CanCan::AccessDenied, with: :render_403

  protected

  def render_404( exception )
    render_exception( exception, 404 )
  end

  def render_403( exception )
    render_exception( exception, 403 )
  end

  private

  def render_exception( exception, status )
    respond_to do |format|
      format.all  { render nothing: true, status: status }
    end
  end

  def determine_template
    @template = params[:template] || 'base'
  end
end
