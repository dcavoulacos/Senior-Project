class AddTeammateToAction < ActiveRecord::Migration
  def change
    add_column :actions, :teammate_id, :integer, reference: :player
  end
end
