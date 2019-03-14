class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :users do |t|
      t.string     :userid, :limit => 32, :null => false
      t.string     :username, :limit => 32, :null => false
      t.string     :password, :limit => 32, :null => false
      t.timestamp  :created_at
    end
  end
  def self.down
    drop_table :users
  end
end
