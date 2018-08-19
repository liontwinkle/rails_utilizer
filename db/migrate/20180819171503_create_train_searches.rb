class CreateTrainSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :train_searches do |t|
      t.integer :first_seats_number
      t.integer :second_seats_number
      t.integer :third_seats_number

      t.integer :uz_train_number, null: false
      t.index :uz_train_number

      t.string :uz_search_url

      t.date :uz_departure, null: false # either given by user or got from search_url

      t.references :user, index: true

      t.timestamps
    end
  end
end
