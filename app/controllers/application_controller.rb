class ApplicationController < ActionController::API
  rescue_from GuestParamsInvalid, with: :failure_params_invalid
  rescue_from ReservationParamsInvalid, with: :failure_params_invalid
  
  wrap_parameters format: [:json]

  private
  
    def failure_params_invalid(exception)
      render json: { errors: exception }, status: 400
    end
end
