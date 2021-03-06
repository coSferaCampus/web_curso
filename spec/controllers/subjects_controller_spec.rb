require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:subject).keys

  before :all do
    @student = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @model = Subject
    @resource = FactoryGirl.create(:subject)
    @parameters = FactoryGirl.attributes_for(:subject)
    @list_options = {}
    @index_params = {}
    @first_page_resources = Subject.all
    @update_params = FactoryGirl.attributes_for(:subject_updated)
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
            post :create, subject: @parameters
            expect(response.status).to eql status
          end
        end
      end
    end

    context "PUT #update" do
      let(:sub){ FactoryGirl.create(:subject) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            put :update, id: sub.id,
              subject: FactoryGirl.attributes_for(:subject)
            expect(response.status).to eql status
          end
        end
      end
    end

    context "DELETE #destroy" do
      let(:sub){ FactoryGirl.create(:subject) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            delete :destroy, id: sub.id
            expect(response.status).to eql status
          end
        end
      end
    end
  end
end
