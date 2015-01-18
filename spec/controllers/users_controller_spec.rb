require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:admin){ FactoryGirl.create :admin }

  set_content_type 'application/json'

  options = [:show, :index, :create, :destroy]
  json_attributes = [:email]

  before :all do
    @model = User
    @resource = FactoryGirl.create(:user)
    @parameters = FactoryGirl.attributes_for(:user)
    @list_options = {}
    @index_params = {}
    @first_page_resources = User.all
  end

  before do
    sign_in admin
  end

  it_behaves_like "a REST controller", options, json_attributes
end
