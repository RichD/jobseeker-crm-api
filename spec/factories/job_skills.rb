FactoryBot.define do
  factory :job_skill do
    association :job
    association :skill
    years_required { nil }
    classification { "required" }

    trait :required do
      classification { "required" }
      years_required { 5 }
    end

    trait :preferred do
      classification { "preferred" }
    end

    trait :mentioned do
      classification { "mentioned" }
    end
  end
end
