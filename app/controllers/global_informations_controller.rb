class GlobalInformationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @global_information, api_template: @template
  end

  def index
    @global_informations = GlobalInformation.desc(:created_at)
    respond_with @global_informations, api_template: @template, root: 'global_informations'
  end

  def create
    authorize! :create, GlobalInformation
    @global_information = GlobalInformation.create(file_params)
    respond_with @global_information, api_template: @template
  end

  def update
    @global_information.update_attributes(file_params)
    respond_with @global_information, api_template: @template
  end

  def destroy
    @global_information.destroy
    respond_with @global_information, api_template: @template
  end

  private

  def file_params
    params.require(:global_information).permit(:name, :value)
  end
end
