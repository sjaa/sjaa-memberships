class CreateMeetupEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :meetup_events do |t|
      t.string :meetup_id
      t.string :url
      t.string :image_url
      t.string :title
      t.datetime :time

      t.timestamps
    end
    add_index :meetup_events, :meetup_id, unique: true
  end
end
