class AddVerifiedAndRelevantStatus < ActiveRecord::Migration
  def change
    add_column :events, :relevant, :boolean
  end
end
