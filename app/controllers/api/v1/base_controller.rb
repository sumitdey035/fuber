class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  protected

  # def base(status, data = {})
  #   ActiveSupport::JSON.encode({status: CONFIG[:application][:status][status.to_s], data: data})
  # end

  def render_json_response(response, action_type)
    app_status = response[:status].to_i
    http_status = case action_type
                    when :create then
                      if app_status == 200
                        :created
                      elsif app_status == 600
                        :ok
                      else
                        :unprocessable_entity
                      end
                    when :read, :update then
                      if app_status == 200
                        :ok
                      elsif app_status == 300
                        :bad_request
                      elsif app_status == 400
                        :unauthorized
                      elsif app_status == 500
                        :not_found
                      else
                        :unprocessable_entity
                      end
                    when :delete then
                      app_status
                    when :crud then
                      if app_status == 200
                        :ok
                      elsif app_status == 300
                        :bad_request
                      end
                  end

    render json: ActiveSupport::JSON.encode({status: CONFIG["status_code"][app_status], message: response[:message],
                                             data: response[:data]}), status: http_status
  end
end
