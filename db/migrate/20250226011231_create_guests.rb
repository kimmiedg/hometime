class CreateGuests < ActiveRecord::Migration[7.2]
  def change
    create_table :guests do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone

      t.timestamps
    end

    add_index :guests, :email
  end
end
