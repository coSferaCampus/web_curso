FactoryGirl.define do
  factory :global_information do
    name
    value "a value"
  end

  factory :global_information_updated, parent: GlobalInformation do
    name "New name"
    value  "New value"
  end
end
