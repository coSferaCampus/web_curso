class SubjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create]

  respond_to :json

  def show
    respond_with @subject, respond_parameters
  end

  def index
    @subjects = Subject.all
    respond_with @subjects, respond_parameters
  end

  def create
    authorize! :create, Subject
    @subject = Subject.create(subject_create_params)
    respond_with @subject, respond_parameters
  end

  def update
    @subject.update_attributes(subject_update_params)
    respond_with @subject
  end

  def destroy
    @subject.destroy
    respond_with @subject
  end

  private

  def subject_create_params
    params.require(:subject).permit(:name)
  end

  def subject_update_params
    params.require(:subject).permit(:name)
  end
end
