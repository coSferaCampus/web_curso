class GlobalInformationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @global_information, respond_parameters
  end

  def index
    @global_informations = GlobalInformation.desc(:created_at)
    respond_with @global_informations, respond_parameters
  end

  def create
    authorize! :create, GlobalInformation
    @global_information = GlobalInformation.create(file_params)
    respond_with @global_information, respond_parameters
  end

  def update
    @global_information.update_attributes(file_params)
    respond_with @global_information
  end

  def destroy
    @global_information.destroy
    respond_with @global_information
  end

  private

  def file_params
    params.require(:global_information).permit(:name, :value)
  end
end
