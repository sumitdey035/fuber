class RideDecorator < Draper::Decorator
  def start_time
    object.start_time.strftime('%I:%M %p %A, %B %e')
  end

  def end_time
    object.end_time.strftime('%I:%M %p %A, %B %e')
  end

  def duration
    "#{object.duration} min"
  end

  def distance
    "#{object.distance_in_km} km" if object.distance_in_km
  end

  def price
    "#{object.price} D" if object.price
  end
end