class FileResourcesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @file_resource, api_template: @template
  end

  def index
    @file_resources = FileResource.desc(:created_at)
    respond_with @file_resources, api_template: @template, root: 'file_resources'
  end

  def create
    authorize! :create, FileResource
    @file_resource = FileResource.create(file_create_params)
    respond_with @file_resource, api_template: @template
  end

  def update
    @file_resource.update_attributes(file_update_params)
    respond_with @file_resource, api_template: @template
  end

  def destroy
    @file_resource.destroy
    respond_with @file_resource, api_template: @template
  end

  private

  def file_create_params
    params.require(:file_resource).permit(:name, :file)
  end

  def file_update_params
    params.require(:file_resource).permit(:name)
  end
end
