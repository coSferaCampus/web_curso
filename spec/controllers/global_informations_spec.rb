require 'rails_helper'

RSpec.describe GlobalInformationsController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:name, :value]

  before :all do
    @student = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @model = GlobalInformation
    @resource = FactoryGirl.create(:global_information)
    @create_params = {}
    @parameters = FactoryGirl.attributes_for(:global_information)
    @list_options = {}
    @index_params = {}
    @first_page_resources = GlobalInformation.all.desc(:created_at)
    @update_params = FactoryGirl.attributes_for(:global_information_updated)
    @destroy_params = {}
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
            post :create, global_information: @parameters
            expect(response.status).to eql status
          end
        end
      end
    end

    context "PUT #update" do
      let(:global_information){ FactoryGirl.create(:global_information) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            put :update, id: global_information.id,
              global_information: FactoryGirl.attributes_for(:global_information)
            expect(response.status).to eql status
          end
        end
      end
    end

    context "DELETE #destroy" do
      let(:global_information){ FactoryGirl.create(:global_information) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            delete :destroy, id: global_information.id
            expect(response.status).to eql status
          end
        end
      end
    end
  end
end
