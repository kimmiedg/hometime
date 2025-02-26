module Api
module V1
  class ReservationSerializer < BaseSerializer
    attributes :start_date,
               :end_date,
               :nights,
               :guests,
               :adults,
               :children,
               :infants,
               :currency,
               :status,
               :payout_price,
               :security_price,
               :total_price

    belongs_to :guest, serializer: Api::V1::GuestSerializer
  end
end
end
