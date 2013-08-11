class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name, presence: true
      t.string :handle, presence: true
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
