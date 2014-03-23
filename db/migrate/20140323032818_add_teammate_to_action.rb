class AddTeammateToAction < ActiveRecord::Migration
  def change
  	add_column :actions, :teammate, :integer, reference: :player
  end
end
