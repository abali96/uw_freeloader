class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :food_type
      t.string :location
      t.datetime :start_time
      t.integer :quantity
      t.string :quality
      t.integer :awkwardness
      t.string :wait_time
      t.timestamps
    end
  end
end
