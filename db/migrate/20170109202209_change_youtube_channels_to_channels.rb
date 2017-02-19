class ChangeYoutubeChannelsToChannels < ActiveRecord::Migration
  def change
    rename_table :youtube_channels, :channels
    rename_column :channel_assignments, :youtube_channel_id, :channel_id
    rename_column :videos, :youtube_channel_id, :channel_id
    add_column :channels, :type, :string
    Channel.update_all(type: "YoutubeChannel")
  end
end
