FactoryBot.define do
  factory :job do
    association :user
    sequence(:title) { |n| "Job Title #{n}" }
    sequence(:company) { |n| "Company #{n}" }
    url { "https://example.com/jobs/#{rand(1000)}" }
    location { "Remote" }
    status { :saved }
    description { "Job description text" }
    notes { "My notes" }
    compensation { "$100k-150k" }
    applied_at { nil }

    # Trait for applied jobs
    trait :applied do
      status { :applied }
      applied_at { 1.day.ago }
    end

    # Trait for interviewing
    trait :interviewing do
      status { :interviewing }
      applied_at { 1.week.ago }
    end
  end
end
