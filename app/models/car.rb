class Car < ActiveRecord::Base
  KM_RATE   = 2
  TIME_RATE = 2

  scope :desc,      -> { order(id: :desc) }
  scope :available, -> { where(available: true) }

  has_many :rides, dependent: :destroy

  def self.nearest
    available.first
  end
end
