class ThemesController < ApplicationController
  respond_to :json

  def show
    @theme = Theme.find(params[:id])
    respond_with @theme, api_template: @template
  end

  def index
    @themes = Subject.find(params[:subject_id]).themes.asc(:number)
    respond_with @themes, api_template: @template, root: 'themes'
  end

  def create
    @theme = Subject.find(params[:subject_id]).themes.create(theme_create_params)
    respond_with @theme, api_template: @template
  end

  def update
    @theme = Theme.find(params[:id])
    @theme.update_attributes(theme_update_params)
    respond_with @theme, api_template: @template
  end

  def destroy
    @theme = Theme.find(params[:id])
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
