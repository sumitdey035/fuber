10.times do
  Customer.create(name: Faker::Name.name)
end

75.times do
  NormalCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: 1.32, lng: 103.22)
end

25.times do
  PinkCar.create(model: Faker::Vehicle.manufacture, uniq_id: Faker::Vehicle.vin, lat: 1.32, lng: 103.22)
end

25.times do
  car         = Car.all.sample
  customer    = Customer.all.sample
  start_time  = Faker::Time.between(Date.today, Date.today, :evening)
  end_time    = Faker::Time.between(Date.today, Date.today, :night)

  Ride.create(
    customer_id:  customer.id,
    car_id:       car.id,
    start_point:  "#{car.lat}, #{car.lng}",
    end_point:    "#{car.lat}, #{car.lng}",
    distance:     35,
    start_time:   start_time,
    end_time:     end_time
  )
end
