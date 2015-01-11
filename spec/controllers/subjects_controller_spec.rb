require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:subject).keys

  before :all do
    @model = Subject
    @resource = FactoryGirl.create(:subject)
    @parameters = FactoryGirl.attributes_for(:subject)
    @list_options = {}
    @index_params = {}
    @first_page_resources = Subject.all
    @update_params = FactoryGirl.attributes_for(:subject_updated)
  end

  it_behaves_like "a REST controller", options, json_attributes
end
