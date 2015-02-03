require 'rails_helper'

RSpec.describe FileResource, type: :model do
  context "Fields" do
    it{ should have_field(:name).of_type(String) }
    it{ should have_field(:url).of_type(String) }
  end

  context "Validations" do
    it{ should validate_presence_of(:name) }
    it{ should validate_presence_of(:url) }

    it{ should validate_uniqueness_of(:name) }
  end
end
