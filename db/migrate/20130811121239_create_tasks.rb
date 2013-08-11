class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :notes
      t.string :status
      t.integer :doer_id
      t.integer :asker_id

      t.timestamps 
    end
  end
end
