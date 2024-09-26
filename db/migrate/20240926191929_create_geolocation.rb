class CreateGeolocation < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :network_address, null: false
      t.json :response, null: false

      t.timestamps
    end
  end
end
