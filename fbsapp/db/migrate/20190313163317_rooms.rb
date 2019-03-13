class Rooms < ActiveRecord::Migration[5.2]
    def self.up
        create_table :rooms do |t|
          t.string     :roomid, :limit => 32, :null => false
          t.string     :name, :limit => 32, :null => false
          t.text     :description
          t.timestamp  :created_at
        end
    end
    def self.down
        drop_table :rooms
    end
end
