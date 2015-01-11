FactoryGirl.define do
  factory :subject do
    name
  end

  factory :subject_updated, parent: Subject do
    name 'Name Updated'
  end
end
