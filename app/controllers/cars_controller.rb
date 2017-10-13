class CarsController < ApplicationController
  def index
    @cars = Car.includes(:rides).all.desc
  end
end
