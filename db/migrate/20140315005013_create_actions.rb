class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
    	t.references :action_frame, index: true
      t.references :player, index: true

    	t.string :action_type

    	# End positions only updated for moving types (run and dribble). Else,
    	# same as player.position_x/y.
    	t.decimal :end_position_x
    	t.decimal :end_position_y

      t.timestamps
    end
  end
end
