class AddVideosYoutubeChannels < ActiveRecord::Migration
  def change
    create_table :videos_youtube_channels do |t|
      t.belongs_to :video, index: true
      t.belongs_to :youtube_channel, index: true

      t.timestamps null: false
    end
  end
end
