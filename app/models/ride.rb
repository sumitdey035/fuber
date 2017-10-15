class Ride < ActiveRecord::Base
  include Calculation

  validates :car_id, :customer_id, :start_time, :start_point, presence: true

  belongs_to :car
  belongs_to :customer

  scope :desc,          -> { order(start_time: :desc) }

  before_validation :set_distance, :set_price

  # Duration of a ride in minute
  def duration
    end_time ||= Time.now.utc
    ((end_time - start_time)/60).round
  end

  # Check whether the ride is over or ongoing
  def ongoing?
    end_point.blank?
  end

  private
  def set_distance
    return unless end_point
    self.distance = cauculate_distance(start_point, end_point)
  end

  def set_price
    return unless distance
    self.price = calculate_price
  end
end
