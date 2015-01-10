FactoryGirl.define do
  sequence :number do |n|
    n
  end

  sequence :name do |n|
    "Subject #{n}"
  end
end
