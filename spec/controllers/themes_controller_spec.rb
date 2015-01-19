require 'rails_helper'

RSpec.describe ThemesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:number]
  no_check_values = [:file]

  before :all do
    @student = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @model = Theme
    @sub = FactoryGirl.create(:subject)
    @resource = FactoryGirl.create(:theme, subject: @sub)
    @create_params = {subject_id: @sub.id.to_s}
    @parameters = FactoryGirl.attributes_for(:theme)
    @list_options = {subject_id: @sub.id.to_s}
    @index_params = {subject_id: @sub.id.to_s}
    @first_page_resources = @sub.themes.asc(:number)
    @update_params = FactoryGirl.attributes_for(:theme_updated)
    @destroy_params = {subject_id: @sub.id.to_s}
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
            get :index, subject_id: @sub.id
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
            post :create, theme: @parameters, subject_id: @sub.id
            expect(response.status).to eql status
          end
        end
      end
    end

    context "PUT #update" do
      let(:theme){ FactoryGirl.create(:theme, subject: @sub) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            put :update, id: theme.id,
              theme: FactoryGirl.attributes_for(:theme)
            expect(response.status).to eql status
          end
        end
      end
    end

    context "DELETE #destroy" do
      let(:theme){ FactoryGirl.create(:theme, subject: @sub) }

      {admin: 204, student: 403}.each do |user, status|
        context "#{user}" do
          it "should return #{status} HTTP status code" do
            sign_in instance_variable_get "@#{user}"
            delete :destroy, id: theme.id
            expect(response.status).to eql status
          end
        end
      end
    end
  end
end
