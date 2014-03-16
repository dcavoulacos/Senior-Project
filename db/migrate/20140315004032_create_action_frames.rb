class CreateActionFrames < ActiveRecord::Migration
  def change
    create_table :action_frames do |t|
    	t.string :name
    	t.boolean :ends_set
    	
    	t.timestamps
    end
  end
end
