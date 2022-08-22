class CreateCategoryDictionariesPlacesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :category_dictionaries, :places
  end
end
