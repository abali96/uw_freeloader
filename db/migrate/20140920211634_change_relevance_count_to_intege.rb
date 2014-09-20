class ChangeRelevanceCountToIntege < ActiveRecord::Migration
  def up
     change_column :events, :relevant, :boolean
   end

   def down
     change_column :events, :relevant, :float
   end
end
