class CreateUserFavoriteTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :user_favorite_trips do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
