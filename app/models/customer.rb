class Customer < ActiveRecord::Base
  scope :hipster,       -> { where(hipster: true) }
  scope :not_hipster,   -> { where(hipster: false) }
  scope :desc,          -> { order(id: :desc) }

  has_many :rides, dependent: :destroy
end