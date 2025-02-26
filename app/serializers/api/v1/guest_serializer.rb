module Api
module V1
  class GuestSerializer < BaseSerializer
    attributes :id,
               :first_name,
               :last_name,
               :email,
               :phone
  end
end
end
