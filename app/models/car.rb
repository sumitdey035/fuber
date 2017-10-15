class Car < ActiveRecord::Base
  KM_RATE   = 2
  TIME_RATE = 1

  validates :type, :model, :uniq_id, :lat, :lng, presence: true
  validates_uniqueness_of :uniq_id

  scope :desc,          -> { order(id: :desc) }
  scope :available,     -> { where(available: true) }
  scope :not_available, -> { where.not(available: true) }

  has_many :rides, dependent: :destroy

  # Fetch the nearest available taxi to the customer
  def self.nearest
    available.first
  end
end
