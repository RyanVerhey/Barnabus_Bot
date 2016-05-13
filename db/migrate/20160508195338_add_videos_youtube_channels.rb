class AddVideosYoutubeChannels < ActiveRecord::Migration
  def change
    create_table :videos_youtube_channels do |t|
      t.string :video_id, index: true
      t.string :youtube_channel_id, index: true

      t.timestamps null: false
    end
  end
end
