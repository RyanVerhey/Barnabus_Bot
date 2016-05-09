class AddSubredditsAndYoutubeChannels < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string  :name
      t.belongs_to :reddit_account

      t.timestamps null: false
    end

    create_table :youtube_channels do |t|
      t.string  :name

      t.timestamps null: false
    end

    create_table :channel_assignments do |t|
      t.belongs_to :subreddit, index: true
      t.belongs_to :youtube_channel, index: true
      t.string  :regexp

      t.timestamps null: false
    end
  end
end
