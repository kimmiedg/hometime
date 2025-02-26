module Api
module V1
  class ReservationsController < ApplicationController
  
    def create
      @reservation = Reservations::CreateService.call(params)
      render_one(@reservation)
    end

    private
      def render_one(reservation)
        render json: reservation,
               serializer: Api::V1::ReservationSerializer,
               status: :ok
      end
  end
end
end