class FileResourcesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @file_resource, respond_parameters
  end

  def index
    @file_resources = FileResource.desc(:created_at)
    respond_with @file_resources, respond_parameters
  end

  def create
    authorize! :create, FileResource
    @file_resource = FileResource.create(file_params)
    respond_with @file_resource, respond_parameters
  end

  def update
    @file_resource.update_attributes(file_params)
    respond_with @file_resource
  end

  def destroy
    @file_resource.destroy
    respond_with @file_resource
  end

  private

  def file_params
    params.require(:file_resource).permit(:name, :url)
  end
end
