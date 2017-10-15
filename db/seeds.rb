7.times do
  Customer.create(name: Faker::Name.name)
end

3.times do
  Customer.create(name: Faker::Name.name, hipster: true)
end

75.times do
  NormalCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: rand(12.8607..13.1501).round(4), lng: rand(77.3973..77.5903).round(4))
end

25.times do
  PinkCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: rand(12.8607..13.1501).round(4), lng: rand(77.3973..77.5903).round(4))
end

17.times do
  car         = NormalCar.all.sample
  customer    = Customer.not_hipster.sample

  Ride.create!(
    customer_id:  customer.id,
    car_id:       car.id,
    start_point:  "#{rand(12.8607..13.1501).round(4)},#{rand(77.3973..77.5903).round(4)}",
    end_point:    "#{rand(12.8607..13.1501).round(4)},#{rand(77.3973..77.5903).round(4)}",
    start_time:   Faker::Time.between(Date.yesterday, Date.yesterday, [:afternoon, :morning].sample),
    end_time:     Faker::Time.between(Date.yesterday, Date.yesterday, :night)
  )
end

8.times do
  car         = PinkCar.all.sample
  customer    = Customer.hipster.sample

  Ride.create!(
    customer_id:  customer.id,
    car_id:       car.id,
    start_point:  "#{rand(12.860714..13.150126).round(4)},#{rand(77.397327..77.590329).round(4)}",
    end_point:    "#{rand(12.860714..13.150126).round(4)},#{rand(77.397327..77.590329).round(4)}",
    start_time:   Faker::Time.between(Date.yesterday, Date.yesterday, [:afternoon, :morning].sample),
    end_time:     Faker::Time.between(Date.yesterday, Date.yesterday, :night)
  )
end
