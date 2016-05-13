class AddVideos < ActiveRecord::Migration
  def change
    create_table :videos, id: false do |t|
      t.string   :id
      t.text     :title
      t.text     :description
      t.string   :author
      t.string   :url
      t.datetime :published_at
      t.string   :youtube_channel_id

      t.index :id, unique: true

      t.timestamps null: false
    end
    execute "ALTER TABLE videos ADD PRIMARY KEY (id);"
  end
end
