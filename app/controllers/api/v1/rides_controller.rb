class Api::V1::RidesController < Api::V1::BaseController
  before_action :set_customer
  before_action :set_ride, only: [:show, :destroy]

  # index action is used to fetch rides for an user.
  # parameter:
  #   None
  # ==== Examples
  #
  # request json
  #   GET base_url/api/v1/customers/1/rides
  def index
    render json: @customer.rides.desc
  end

  # create action is used to stop one ride for an user.
  # parameter:
  #   required: start_point
  # ==== Examples
  #
  # request url
  #   POST base_url/api/v1/customers/1/ride/1?start_point=1.3,103.2
  def create
    response = if nearest_car = Car.nearest
                 ride = @customer.rides.build(car_id: nearest_car.id, start_point: params[:start_point], start_time: Time.now.utc)
                 if ride.save
                   {status: 200, message: I18n.t('ride.start.successful'), data: ride}
                 else
                   {status: 700, message: I18n.t('error.validation'), data: ride.errors.full_messages}
                 end
               else
                 {status: 500, message: I18n.t('ride.start.notaxy'), data: nil}
               end
    render_json_response(response, :create)
  end

  # show action is used to fetch one ride details for an user.
  # parameter:
  #   None
  # ==== Examples
  #
  # request url
  #   GET base_url/api/v1/customers/1/ride/1
  def show
    render_json_response({ status: 200, message: nil, data: @ride }, :read)
  end

  # destroy action is used to stop one ride for an user.
  # parameter:
  #   required: end_point
  # ==== Examples
  #
  # request url
  #   DELETE base_url/api/v1/customers/1/ride/1?end_point=1.3,103.2
  def destroy
    response= if @ride.ongoing?
                if @ride.update(end_point: params[:end_point], end_time: Time.now.utc)
                  {
                    status: 200,
                    message: I18n.t('ride.stop.successful'),
                    data: @ride
                  }
                end
              else
                {status: 600, message: I18n.t('ride.stop.unsuccessful'), data: @ride}
              end
    render_json_response(response, :create)
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
