module Reservations
  class ReservationPayload
    def initialize(payload)
      @payload = payload
    end

    def self.call(payload)
      new(payload).call
    end

    def call
      process_payload
    end

    private

      def process_payload
        reservation_params = first_payload
        reservation_params = second_payload if reservation_params.nil?
        raise ReservationParamsInvalid unless is_params_valid?(reservation_params)

        reservation_params = ActionController::Parameters.new(reservation_params)
        strong_params(reservation_params)
      end

      def first_payload
        return if @payload.dig(:reservation, :guest_details).present?

        reservation = { start_date: @payload[:start_date],
                        end_date: @payload[:end_date],
                        nights: @payload[:nights],
                        guests: @payload[:guests],
                        adults: @payload[:adults],
                        children: @payload[:children],
                        infants: @payload[:infants],
                        currency: @payload[:currency],
                        status:@payload[:status],
                        payout_price: @payload[:payout_price],
                        security_price: @payload[:security_price],
                        total_price: @payload[:total_price] }
        raise ReservationParamsInvalid unless is_params_valid?(reservation)
        
        reservation
      end
      
      def second_payload
        reservation = @payload[:reservation]
        return unless @payload[:reservation].key?(:guest_details)  
        
        reservation = { start_date: reservation[:start_date],
                        end_date: reservation[:end_date],
                        nights: reservation[:nights],
                        guests: extract_guest_count(reservation[:guest_details][:localized_description]),
                        adults: reservation[:guest_details][:number_of_adults],
                        children: reservation[:guest_details][:number_of_children],
                        infants: reservation[:guest_details][:number_of_infants],
                        currency: reservation[:host_currency],
                        status:reservation[:status_type],
                        payout_price: reservation[:expected_payout_amount],
                        security_price: reservation[:listing_security_price_accurate],
                        total_price: reservation[:total_paid_amount_accurate] }
        raise ReservationParamsInvalid unless is_params_valid?(reservation)
        
        reservation
      end

      def strong_params(reservation)
        reservation.permit(:start_date, 
                            :end_date, 
                            :nights, 
                            :guests, 
                            :adults, 
                            :children, 
                            :infants, 
                            :currency, 
                            :payout_price, 
                            :security_price, 
                            :total_price, 
                            :status)
      end

      def is_params_valid?(params)
        missing_fields = params.select { |_, value| value.blank? }.keys
        missing_fields.empty?  
      end

      def extract_guest_count(str)
        return 0 unless str
        
        str[/\d+(?=\s+guests)/].to_i
      end
  end
end