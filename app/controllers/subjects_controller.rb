class SubjectsController < ApplicationController
  respond_to :json

  def show
    @subject = Subject.find(params[:id])
    respond_with @subject, api_template: @template
  end

  def index
    @subjects = Subject.all
    respond_with @subjects, api_template: @template, root: 'subjects'
  end

  def create
    @subject = Subject.create(subject_create_params)
    respond_with @subject, api_template: @template
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update_attributes(subject_update_params)
    respond_with @subject, api_template: @template
  end

  def destroy
    @subject = Subject.find(params[:id])
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
