class SetDefaultRelevant < ActiveRecord::Migration
  def change
  	change_column :events, :relevant, :boolean, :default => true
  end
end
