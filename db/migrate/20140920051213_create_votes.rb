class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :event_id
      t.boolean :exists
      t.integer :user_id


      t.timestamps
    end
  end
end
