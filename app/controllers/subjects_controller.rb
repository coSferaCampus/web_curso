class SubjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @subject, api_template: @template
  end

  def index
    @subjects = Subject.all
    respond_with @subjects, api_template: @template, root: 'subjects'
  end

  def create
    @subject = Subject.new(subject_create_params)
    authorize! :create, @subject
    @subject.save
    respond_with @subject, api_template: @template
  end

  def update
    @subject.update_attributes(subject_update_params)
    respond_with @subject, api_template: @template
  end

  def destroy
    @subject.destroy
    respond_with @subject, api_template: @template
  end

  private

  def subject_create_params
    params.require(:subject).permit(:name)
  end

  def subject_update_params
    params.require(:subject).permit(:name)
  end
end
