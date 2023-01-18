class CreateJourneyPlaceInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :journey_place_infos do |t|
      t.belongs_to :journey, null: false, foreign_key: true
      t.belongs_to :place, null: false, foreign_key: true
      t.string :status, default: 'inactive'

      t.timestamps
    end
  end
end
