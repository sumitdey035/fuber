class RideDecorator < Draper::Decorator
  def start_time
    object.start_time.strftime('%I:%M %p %A, %b %e')
  end

  def end_time
    object.end_time.strftime('%I:%M %p %A, %B %e')
  end

  def duration
    object.duration > 59 ? "#{object.duration/60}h #{object.duration % 60}min" : "#{object.duration % 60}min"
  end

  def distance
    "#{object.distance} km" if object.distance
  end

  def price
    "#{object.price} D" if object.price
  end
end