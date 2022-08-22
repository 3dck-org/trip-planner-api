class CreateCategoryDictionaries < ActiveRecord::Migration[7.0]
  def change
    create_table :category_dictionaries do |t|
      t.string :name

      t.timestamps
    end
  end
end
