FactoryGirl.define do
  sequence :number do |n|
    n
  end

  sequence :name do |n|
    "Subject #{n}"
  end

  sequence :email do |n|
    "user#{n}@email.com"
  end
end
