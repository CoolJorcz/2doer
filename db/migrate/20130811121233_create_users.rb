class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, presence: true
      t.string :last_name, presence: true
      t.string :twitter_handle, presence: true
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end
