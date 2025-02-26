class ApiError < StandardError
  
  def api_response
    { code: api_code, message: api_message, data: data }.compact_blank!
  end

  def http_status
    :unprocessable_entity
  end

  private

  def api_code
    'unknown_error'
  end

  def api_message
    'Cannot process request'
  end

  def data
    nil
  end
end
