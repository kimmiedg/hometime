class ReservationParamsInvalid < ApiError
    
  def intialize
    super()
  end

  private

  def api_code
    'reservation_params_invalid'
  end

  def api_message
    "Reservation params invalid"
  end
end