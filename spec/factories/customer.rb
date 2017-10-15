FactoryGirl.define do
  factory :customer, class: Customer do
    name  { Faker::Name.name }

    trait :hipster do
      hipster true
    end
  end
end