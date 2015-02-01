FactoryGirl.define do
  factory :file_resource do
    name
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/samples/example.md')), 'text/plain')
  end

  factory :file_resource_updated, parent: FileResource do
    name "New name"
  end
end
