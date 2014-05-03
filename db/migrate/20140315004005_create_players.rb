class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
    	t.references :set_play, index: true

    	# Role refers to player position: 1(PG), 2(SG), 3(SF), 4(PF) and 5(C).
    	t.string :role

    	t.decimal :position_x
    	t.decimal :position_y
    	t.boolean :has_ball

    	t.timestamps
    end
  end
end
