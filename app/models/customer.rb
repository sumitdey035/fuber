class Customer < ActiveRecord::Base
  validates :name, presence: true

  scope :desc,          -> { order(id: :desc) }
  scope :hipster,       -> { where(hipster: true) }
  scope :not_hipster,   -> { where(hipster: false) }

  has_many :rides
end