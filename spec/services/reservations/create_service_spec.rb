require 'rails_helper'

RSpec.describe Reservations::CreateService, type: :service do
  describe '.call' do
   context 'when first payload' do
    let(:payload) do 
      { "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": { "first_name": "Wayne",
                   "last_name": "Woodbridge",
                   "phone": "639123456789",
                   "email": "wayne_woodbridge@bnb.com" },
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00" }
    end
    let(:reservation) { described_class.call(payload) }

    it 'should return guest info' do
      expect(reservation.guest.first_name).to eq(payload[:guest][:first_name])
      expect(reservation.guest.email).to eq(payload[:guest][:email])
    end

    it 'should return reservation' do
      expect(reservation.start_date).to eq(payload[:start_date].to_date)
      expect(reservation.children).to eq(payload[:children])
    end
   end

   context 'when second payload' do
    let(:payload) do 
      {
        "reservation": {
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_id": 1,
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4500.00"
        }
      }
    end
    let(:reservation) { described_class.call(payload) }

    it 'should return guest info' do
      expect(reservation.guest.first_name).to eq(payload[:reservation][:guest_first_name])
      expect(reservation.guest.email).to eq(payload[:reservation][:guest_email])
    end

    it 'should return reservation' do
      expect(reservation.start_date).to eq(payload[:reservation][:start_date].to_date)
      expect(reservation.children).to eq(payload[:reservation][:guest_details][:number_of_children])
    end
   end
  end
end