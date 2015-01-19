require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:admin){ FactoryGirl.create :admin }

  set_content_type 'application/json'

  options = [:show, :index, :create, :destroy]
  json_attributes = [:email]

  before :all do
    @student = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @model = User
    @resource = FactoryGirl.create(:user)
    @parameters = FactoryGirl.attributes_for(:user)
    @list_options = {}
    @index_params = {}
    @first_page_resources = User.all
  end

  before do
    sign_in @admin
  end

  it_behaves_like "a REST controller", options, json_attributes

  context "abilities" do
    before do
      sign_out :user
    end

    context "GET #show" do
      {admin: 200, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            get :show, id: @resource.id
            expect(response.status).to eql status
          end
        end
      end
    end

    context "GET #index" do
      {admin: 200, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            get :index
            expect(response.status).to eql status
          end
        end
      end
    end

    context "POST #create" do
      {admin: 201, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            post :create, user: @parameters
            expect(response.status).to eql status
          end
        end
      end
    end

    context "DELETE #destroy" do
      let(:new_user){ FactoryGirl.create(:user) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            delete :destroy, id: new_user.id
            expect(response.status).to eql status
          end
        end
      end
    end
  end
end
