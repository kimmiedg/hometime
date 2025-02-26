class ReservationParamsInvalid < ApiError
  
  def intialize(model)
    super()
    @model = model
  end

  private

  def api_code
    "#{@model}_not_created"
  end

  def api_message
    "#{@model} could not be created"
  end
end