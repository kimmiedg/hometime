require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'POST /api/reservations' do
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

      let(:expected_response) do 
        { "start_date" => "2021-03-12",
          "end_date" => "2021-03-16",
          "nights" => 4,
          "guests" => 4,
          "adults" => 2,
          "children" => 2,
          "infants" => 0,
          "currency" => "AUD",
          "status" => "accepted",
          "payout_price" => 3800.0,
          "security_price" => 500.0,
          "total_price" => 4500.0 }
      end

      let(:expected_guest) do
        { "first_name" => "Wayne",
          "last_name" => "Woodbridge",
          "email" => "wayne_woodbridge@bnb.com",
          "phone" => "639123456789" }
      end

      it 'must be successfully created' do
        post :create, params: payload, as: :json
        
        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response).to include(expected_response)
        expect(json_response["guest"]).to include(expected_guest)
        expect(json_response["guest"]["id"]).to be_present
      end
    end

    context 'when second payload' do
      let(:second_payload) do
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

      let(:expected_response) do 
        { "start_date" => "2021-03-12",
          "end_date" => "2021-03-16",
          "nights" => 4,
          "guests" => 4,
          "adults" => 2,
          "children" => 2,
          "infants" => 0,
          "currency" => "AUD",
          "status" => "accepted",
          "payout_price" => 3800.0,
          "security_price" => 500.0,
          "total_price" => 4500.0 }
      end

      let(:expected_guest) do
        { "first_name" => "Wayne",
          "last_name" => "Woodbridge",
          "email" => "wayne_woodbridge@bnb.com",
          "phone" => "639123456789, 639123456789" }
      end

      it 'must be successfully created' do
        post :create, params: second_payload, as: :json
        
        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response).to include(expected_response)
        expect(json_response["guest"]).to include(expected_guest)
        expect(json_response["guest"]["id"]).to be_present
      end
    end
  end
end
