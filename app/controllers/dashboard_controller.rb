class DashboardController < ApplicationController
  def index
    @rides = Ride.includes(:car).all.desc
  end
end
