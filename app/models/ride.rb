class Ride < ActiveRecord::Base
  include Calculation
  validates :car_id, :customer_id, :start_time, :start_point, presence: true

  belongs_to :car
  belongs_to :customer

  scope :desc,          -> { order(start_time: :desc) }

  before_validation :set_distance, :set_price

  # Duration in minute
  def duration
    end_time ||= Time.now
    ((end_time - start_time)/60).round
  end

  def distance_in_km
    return unless distance
    (distance/1000).round(2)
  end

  def ongoing?
    end_point.blank?
  end

  private
  def set_distance
    return unless end_point
    self.distance = cauculate_distance
  end

  def set_price
    return unless distance
    self.price = calculate_price
  end
end
