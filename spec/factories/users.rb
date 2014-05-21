# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    shared_id 1

    trait :with_device do
      devices %w(device_token)
    end
  end
end
