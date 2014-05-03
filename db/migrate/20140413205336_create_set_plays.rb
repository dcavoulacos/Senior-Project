class CreateSetPlays < ActiveRecord::Migration
  def change
    create_table :set_plays do |t|
      t.string :name
      t.references :offense, index: true
      t.integer :currentAF_id
      
      t.timestamps
    end
  end
end
