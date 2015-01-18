FactoryGirl.define do
  factory :user do
    email
    password 'foobarfoo'
    password_changed true

    before(:create) do |user|
      user.skip_confirmation!
    end
  end

  factory :admin, parent: :user do
    admin true
  end
end
