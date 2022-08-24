class CreateTripPlaceInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_place_infos do |t|
      t.belongs_to :trip, null: false, foreign_key: true
      t.belongs_to :place, null: false, foreign_key: true
      t.string :comment
      t.integer :order

      t.timestamps
    end
  end
end
