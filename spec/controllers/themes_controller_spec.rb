require 'rails_helper'

RSpec.describe ThemesController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }

  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:number]
  no_check_values = [:file]

  before :all do
    @model = Theme
    sub = FactoryGirl.create(:subject)
    @resource = FactoryGirl.create(:theme, subject: sub)
    @create_params = {subject_id: sub.id.to_s}
    @parameters = FactoryGirl.attributes_for(:theme)
    @list_options = {subject_id: sub.id.to_s}
    @index_params = {subject_id: sub.id.to_s}
    @first_page_resources = sub.themes.asc(:number)
    @update_params = FactoryGirl.attributes_for(:theme_updated)
    @destroy_params = {subject_id: sub.id.to_s}
  end

  before do
    sign_in user
  end

  it_behaves_like "a REST controller", options, json_attributes, no_check_values
end
