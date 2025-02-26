module Reservations
  class CreateService

    def initialize(payload)
      @payload = payload
    end

    def self.call(payload)
      new(payload).call
    end

    def call
      create_reservation
    end

    private

      def create_reservation
        guest = Guests::CreateService.call(@payload)
        reservation = guest.reservations.new(reservation_params)
        raise ModelNotCreatedError.new(:reservation) unless reservation.save
        reservation
      end
      
      def reservation_params
        Reservations::ReservationPayload.call(@payload)
      end
  end
end
