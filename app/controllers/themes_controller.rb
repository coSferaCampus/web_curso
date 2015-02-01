class ThemesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @theme, api_template: @template
  end

  def index
    @themes = Subject.find(params[:subject_id]).themes.asc(:number)
    respond_with @themes, api_template: @template, root: 'themes'
  end

  def create
    authorize! :create, Theme
    @theme = Subject.find(params[:subject_id]).themes.create(theme_create_params)
    respond_with @theme, api_template: @template
  end

  def update
    @theme.update_attributes(theme_update_params)
    respond_with @theme, api_template: @template
  end

  def destroy
    @theme.destroy
    respond_with @theme, api_template: @template
  end

  private

  def theme_create_params
    params.require(:theme).permit(:number, :file)
  end

  def theme_update_params
    params.require(:theme).permit(:content, :title, :number)
  end
end
