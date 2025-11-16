FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@jobseeker-crm.app" }
    password { "Password123!" }
  end
end
