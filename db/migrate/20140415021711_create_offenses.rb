class CreateOffenses < ActiveRecord::Migration
  def change
    create_table :offenses do |t|
      t.text :name
      t.decimal :pg_x
      t.decimal :pg_y
      t.boolean :pg_ball

      t.decimal :sg_x
      t.decimal :sg_y
      t.boolean :sg_ball

      t.decimal :sf_x
      t.decimal :sf_y
      t.boolean :sf_ball

      t.decimal :pf_x
      t.decimal :pf_y
      t.boolean :pf_ball
      
      t.decimal :c_x
      t.decimal :c_y
      t.boolean :c_ball

      t.timestamps
    end
  end
end
