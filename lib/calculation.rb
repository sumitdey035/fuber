module Calculation
  # The​ price​ is​ ​1 ​dogecoin​ ​ per​ ​ minute,​ and​ ​2 ​dogecoin​ per​ kilometer.​ ​
  # Pink​ cars​ cost​ an additional​ ​5 ​dogecoin.
  # result in dogecoin
  def calculate_price
    return unless distance && duration
    price = distance * Car::KM_RATE  + duration * Car::TIME_RATE
    price += PinkCar::ADDITIONAL_RATE if car.is_a?(PinkCar)
    price
  end

  # distance between two point is in Km
  def cauculate_distance(start_point, end_point)
    Geocoder::Calculations.distance_between(start_point.split(','), end_point.split(','), units: :km).round
  end
end