class Api::V1::RidesController < Api::V1::BaseController
  before_action :set_customer
  before_action :set_ride, only: [:show, :destroy]

  def index
    render json: @customer.rides.desc
  end

  def create
    if nearest_car = Car.nearest
      ride = @customer.rides.build(car_id: nearest_car.id, start_point: params[:start_point], start_time: Time.now.utc )
      if ride.save
        render_json_response({ status: 200, message: I18n.t('ride.start.successful'), data: ride }, :create)
      else
        render_json_response({ status: 700, message: ride.errors.full_messages, data: nil }, :create)
      end
    else
      render_json_response({ status: 500, message: I18n.t('ride.start.notaxy'), data: nil }, :create)
    end
  end

  def show
    render_json_response({ status: 200, message: nil, data: @ride }, :read)
  end

  def destroy
    if @ride.ongoing?
      render_json_response(
        {
          status: 200,
          message: I18n.t('ride.stop.successful'),
          data: @ride
        }, :delete) if @ride.update(end_point: params[:end_point], end_time: Time.now.utc)
    else
      render_json_response({ status: 600, message: I18n.t('ride.stop.unsuccessful'), data: @ride }, :read)
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_ride
    @ride = @customer.rides.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:start_point, :end_point)
  end
end
