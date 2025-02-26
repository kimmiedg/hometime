module Guests
  class CreateService

    def initialize(payload)
      @payload = payload
    end

    def self.call(payload)
      new(payload).call
    end

    def call
     find_or_build_guest 
    end
    
    private
    
    def find_or_build_guest
      raise GuestParamsInvalid if guest_params.nil?

      guest = Guest.find_by_email(guest_params[:email])
      return guest if guest

      Guest.create(guest_params)
    end

    def guest_params
      guest_parameters = guest_first_params
      guest_parameters = guest_second_params if guest_parameters.blank?

      raise GuestParamsInvalid if guest_parameters.blank?

      guest_parameters = ActionController::Parameters.new(guest_parameters)
      guest_parameters.permit(:first_name, :last_name, :phone, :email)
    end

    def guest_first_params
      guest = @payload[:guest] 
      return unless guest

      guest = { first_name: guest[:first_name],
                last_name: guest[:last_name],
                email: guest[:email],
                phone: guest[:phone] }
      raise GuestParamsInvalid unless is_params_valid?(guest)
      
      guest
    end

    def guest_second_params
      reservation = @payload[:reservation]
      
      raise ReservationParamsInvalid if reservation.blank? || reservation.nil?
      
      guest = { first_name: reservation[:guest_first_name],
                last_name: reservation[:guest_last_name],
                email: reservation[:guest_email],
                phone: reservation[:guest_phone_numbers]&.join(', ') }
      raise GuestParamsInvalid unless is_params_valid?(guest)

      guest
    end

    def is_params_valid?(params)
      missing_fields = params.select { |_, value| value.blank? }.keys
      missing_fields.empty?  
    end
  end
end