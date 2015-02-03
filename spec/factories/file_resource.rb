FactoryGirl.define do
  factory :file_resource do
    name
    url "a url"
  end

  factory :file_resource_updated, parent: FileResource do
    name "New name"
    url  "New url"
  end
end
