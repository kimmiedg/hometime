class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :currency
      t.float :payout_price
      t.float :security_price
      t.float :total_price
      t.string :status
      t.integer :guest_id

      t.timestamps
    end
  end
end
