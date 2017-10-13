7.times do
  Customer.create(name: Faker::Name.name)
end

3.times do
  Customer.create(name: Faker::Name.name, hipster: true)
end

75.times do
  NormalCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: 1.32, lng: 103.22)
end

25.times do
  PinkCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: 1.32, lng: 103.22)
end

17.times do
  car         = NormalCar.all.sample
  customer    = Customer.not_hipster.sample

  Ride.create!(
    customer_id:  customer.id,
    car_id:       car.id,
    start_point:  "#{car.lat}, #{car.lng}",
    end_point:    "#{car.lat}, #{car.lng}",
    start_time:   Faker::Time.between(Date.today, Date.today, :evening),
    end_time:     Faker::Time.between(Date.today, Date.today, :night)
  )
end

8.times do
  car         = PinkCar.all.sample
  customer    = Customer.hipster.sample

  Ride.create!(
    customer_id:  customer.id,
    car_id:       car.id,
    start_point:  "#{car.lat}, #{car.lng}",
    end_point:    "#{car.lat}, #{car.lng}",
    start_time:   Faker::Time.between(Date.today, Date.today, :evening),
    end_time:     Faker::Time.between(Date.today, Date.today, :night)
  )
end
