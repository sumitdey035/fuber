FactoryGirl.define do
  factory :ride, class: Ride do
    customer
    car
    start_point   { "#{rand(12.8607..13.1501).round(4)},#{rand(77.3973..77.5903).round(4)}" }
    end_point     { "#{rand(12.8607..13.1501).round(4)},#{rand(77.3973..77.5903).round(4)}" }
    start_time    { Faker::Time.between(Date.yesterday, Date.yesterday, [:afternoon, :morning].sample) }
    end_time      { Faker::Time.between(Date.yesterday, Date.yesterday, :night) }

    trait :hipster do
      hipster true
    end

    trait :ongoing do
      end_point   ''
    end
  end
end