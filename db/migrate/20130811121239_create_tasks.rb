class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text     :body
      t.text     :notes
      t.string   :bluejay
      t.string   :tweet_id
      t.integer  :doer_id
      t.integer  :asker_id
      t.datetime :goal_time
      t.datetime :completed_at
      t.timestamps 
    end
  end
end
