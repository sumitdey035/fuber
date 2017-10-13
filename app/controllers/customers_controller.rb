class CustomersController < ApplicationController
  def index
    @customers = Customer.includes(:rides).all.desc
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
