class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :buildingNumber
      t.string :apartment
      t.string :postalCode

      t.timestamps
    end
  end
end
