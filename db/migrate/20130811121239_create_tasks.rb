class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status
      t.string :accepted
      t.integer :doer_id
      t.integer :asker_id

      t.timestamps 
    end
  end
end
