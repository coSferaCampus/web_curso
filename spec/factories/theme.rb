FactoryGirl.define do
  factory :theme do
    number
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/samples/example.md')), 'text/plain')
  end

  factory :theme_updated, parent: Theme do
    number 130
  end
end
