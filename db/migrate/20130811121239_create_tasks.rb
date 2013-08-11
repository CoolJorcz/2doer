class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   :body
      t.text     :notes
      t.string   :status
      t.integer  :doer_id
      t.integer  :asker_id
      t.datetime :goal_time
      t.datetime :tweeted_at
      t.datetime :completed_at

      t.timestamps 
    end
  end
end
