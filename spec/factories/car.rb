FactoryGirl.define do
  factory :car, class: Car do
    type      'NormalCar'
    model     { Faker::Vehicle.manufacture }
    uniq_id   { Faker::Vehicle.vin }
    lat       { rand(12.8607..13.1501).round(4) }
    lng       { rand(77.3973..77.5903).round(4) }

    trait :pink do
      type  'PinkCar'
    end

    trait :not_available do
      available  false
    end
  end
end