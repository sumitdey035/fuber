module Calculation

  # Unfortunately,​​ skipped​ ​ Geography,​ ​ and​ ​ believe​ ​ the​ ​ earth​ ​ is​ ​ flat.​ ​ The​ ​ distance
  # between​ ​ two​ ​ points​ ​ if ​ calculated​ ​ by​ ​ Pythagoras’​ ​ theorem.
  # result is in Km
  def cauculate_distance
    return unless start_point && end_point
    from  = start_point.split(',').map(&:strip).map(&:to_i)
    to    = end_point.split(',').map(&:strip).map(&:to_i)
    d_ew = (from[1] - from[0]) * Math.cos(from[0])
    d_ns = (to[1] - to[0])

    Math.sqrt(d_ew * d_ew + d_ns * d_ns).round
  end

  # The​ price​ is​ ​1 ​dogecoin​ ​ per​ ​ minute,​ and​ ​2 ​dogecoin​ per​ kilometer.​ ​
  # Pink​ cars​ cost​ an additional​ ​5 ​dogecoin.
  def calculate_price
    return unless distance && duration
    price = distance * Car::KM_RATE  + duration * Car::TIME_RATE
    price += PinkCar::ADDITIONAL_RATE if car.is_a?(PinkCar)
    price
  end
end