class CreateActionFrames < ActiveRecord::Migration
  def change
    create_table :action_frames do |t|
    	t.references :set_play, index: true
    	t.integer :prev_id, index: true
        t.integer :next_id, index: true

    	t.string :name
    	t.boolean :ends_set
    	
    	t.timestamps
    end
  end
end
