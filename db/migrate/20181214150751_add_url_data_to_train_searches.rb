class AddUrlDataToTrainSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :train_searches, :from_station, :string, null: false
    add_column :train_searches, :to_station, :string, null: false
    add_column :train_searches, :start_search_from, :string
  end
end
