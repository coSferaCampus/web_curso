require 'rails_helper'

RSpec.describe Subject, :type => :model do
  context "Fields" do
    it{ should have_field(:name).of_type(String) }
  end

  context "Relations" do
    it{ should have_many(:themes) }
  end

  context "Validations" do
    it{ should validate_presence_of(:name) }

    it{ should validate_uniqueness_of(:name) }
  end
end
