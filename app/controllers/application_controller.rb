class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :determine_template, only: [:show, :index, :create]

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

  # Get the default template
  def default_template
    "#{params[:controller].singularize}_serializer".camelize.constantize
  end

  # Controllers have empty extra templates by default
  def extra_templates
    []
  end

  # Determine which serializer should be used
  def determine_template
    if params[:template].blank? || !extra_templates.include?(params[:template])
      default_template
    else
      "#{params[:controller].singularize}_#{params[:template]}_serializer".camelize.constantize
    end
  end

  # Parameters that should receive respond_with for select serializer and root
  def respond_parameters
    if params[:action] != 'index'
      {serializer: determine_template, root: params[:controller].singularize}
    else
      {each_serializer: determine_template, root: params[:controller]}
    end
  end
end
