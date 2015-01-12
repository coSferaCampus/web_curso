require 'rails_helper'

RSpec.describe Theme, :type => :model do
  let(:sub){ FactoryGirl.create(:subject) }

  context "Fields" do
    it{ should have_field(:number).of_type(Integer) }
    it{ should have_field(:title).of_type(String) }
    it{ should have_field(:subtitles).of_type(Array) }
    it{ should have_field(:content).of_type(String) }
  end

  context "Relations" do
    it{ should belong_to(:subject) }
  end

  context "Validations" do
    it{ should validate_presence_of(:number) }
    it{ should validate_presence_of(:file) }
    it{ should validate_presence_of(:subject) }

    it{ should validate_uniqueness_of(:number).scoped_to(:subject) }
  end

  context "Hooks" do
    subject(:theme){ FactoryGirl.create(:theme, subject: sub) }

    context "after create" do
      it "should assign #content" do
        expect(theme.content).to eql File.read theme.file.path
      end
    end

    context "after save" do
      it "should assign #title" do
        theme.content =~ /^## (.+)$/

        expect(theme.title).to eql $1
      end

      it "should assign #subtitles" do
        subtitles = []
        theme.content.gsub(Theme::SUBTITLE_REGEXP) do |word|
          subtitles << $1
        end

        expect(theme.subtitles).to match_array subtitles
      end
    end
  end
end
