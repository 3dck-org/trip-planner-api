class AddGoogleMapsUrlToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :google_maps_url, :string
  end
end
