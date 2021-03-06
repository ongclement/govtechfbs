class CreateUsers < ActiveRecord::Migration[5.2]
    def self.up
        create_table :users do |t|
          t.string     :username, :limit => 32, :null => false
          t.string     :password, :limit => 32, :null => false
          t.timestamp  :created_at
        end
        User.create :username => "admin", :password => "password"
    end
      def self.down
        drop_table :users
      end
end
