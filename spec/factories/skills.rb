FactoryBot.define do
  factory :skill do
    sequence(:name) { |n| "Skill #{n}" }
    sequence(:slug) { |n| "skill-#{n}" }
    aliases { [] }
    category { "language" }
    popularity { 0 }

    trait :with_aliases do
      name { "Ruby on Rails" }
      slug { "ruby-on-rails" }
      aliases { %w[Rails RoR] }
      category { "framework" }
    end

    trait :language do
      category { "language" }
    end

    trait :framework do
      category { "framework" }
    end
  end
end
