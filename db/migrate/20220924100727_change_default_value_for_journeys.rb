class ChangeDefaultValueForJourneys < ActiveRecord::Migration[7.0]
  def change
    change_column_default :journeys, :completed, false
  end
end
