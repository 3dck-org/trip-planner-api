class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :trip, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :grade

      t.timestamps
    end
  end
end
