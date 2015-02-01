require 'rails_helper'

RSpec.describe FileResourcesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:name]
  no_check_values = [:file]

  before :all do
    @student = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @model = FileResource
    @resource = FactoryGirl.create(:file_resource)
    @create_params = {}
    @parameters = FactoryGirl.attributes_for(:file_resource)
    @list_options = {}
    @index_params = {}
    @first_page_resources = FileResource.all.desc(:created_at)
    @update_params = FactoryGirl.attributes_for(:file_resource_updated)
    @destroy_params = {}
  end

  before do
    sign_in @admin
  end

  it_behaves_like "a REST controller", options, json_attributes, no_check_values

  context "abilities" do
    before do
      sign_out :user
    end

    context "GET #show" do
      {admin: 200, student: 200}.each do |user, status|
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
      {admin: 200, student: 200}.each do |user, status|
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
            post :create, file_resource: @parameters
            expect(response.status).to eql status
          end
        end
      end
    end

    context "PUT #update" do
      let(:file_resource){ FactoryGirl.create(:file_resource) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            put :update, id: file_resource.id,
              file_resource: FactoryGirl.attributes_for(:file_resource)
            expect(response.status).to eql status
          end
        end
      end
    end

    context "DELETE #destroy" do
      let(:file_resource){ FactoryGirl.create(:file_resource) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            delete :destroy, id: file_resource.id
            expect(response.status).to eql status
          end
        end
      end
    end
  end
end
