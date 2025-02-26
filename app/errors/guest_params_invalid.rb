class GuestParamsInvalid < ApiError
    
    def intialize
      super()
    end
  
    private
  
    def api_code
      'guest_params_invalid'
    end
  
    def api_message
      "Guest params invalid or missing"
    end
  end