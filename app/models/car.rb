class Car < ActiveRecord::Base
  include Calculation
  KM_RATE   = 2
  TIME_RATE = 1

  validates :type, :model, :uniq_id, :lat, :lng, presence: true
  validates_uniqueness_of :uniq_id

  scope :desc,          -> { order(id: :desc) }
  scope :available,     -> { where(available: true) }
  scope :not_available, -> { where.not(available: true) }

  has_many :rides

  def start_ride
    update(available: false)
  end

  def stop_ride(end_point)
    lat, lng = end_point.split(',')
    update(available: true, lat: lat, lng: lng)
  end

  # Fetch the nearest available taxi to the customer, return nil if none
  def self.nearest(customer_point)
    return unless nearest_car = available.first
    nearest_distance  = nearest_car.cauculate_distance("#{nearest_car.lat},#{nearest_car.lng}", customer_point)
    available.each do |car|
      current_distance = car.cauculate_distance("#{car.lat},#{car.lng}", customer_point)
      if current_distance < nearest_distance
        nearest_car       = car
        nearest_distance  = current_distance
      end
    end
    nearest_car
  end
end