class CreateBookings < ActiveRecord::Migration[5.2]
  def self.up
    create_table :bookings do |t|
      t.string     :bookingid,    :limit => 32, :null => false
      t.string     :userid,       :limit => 32, :null => false
      t.string     :roomid,       :limit => 32, :null => false
      t.timestamp  :date
      t.string     :startTime,    :limit => 4
      t.string     :endTime,      :limit => 4
      t.string     :status,       :limit => 20

      t.timestamp  :created_at
    end
  end
  def self.down
    drop_table :bookings
  end
end
