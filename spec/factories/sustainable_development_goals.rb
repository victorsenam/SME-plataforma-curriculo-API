FactoryBot.define do
  factory :sustainable_development_goal do
    name { Faker::Name.name }
    description { Faker::Name.name }
    goals 'Goal 1; Goal 2, Goal 3'

    sequence :sequence do |n|
      n
    end

    after(:build) do |sustainable_development_goal|
      sustainable_development_goal.icon.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'images', 'ruby.png')),
        filename: 'ruby.png',
        content_type: 'image/png'
      )
    end

    trait :invalid do
      name nil
      description nil
      goals nil
    end
  end
end
