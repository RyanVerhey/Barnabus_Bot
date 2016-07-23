class AddSubredditsAndYoutubeChannels < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string     :name
      t.belongs_to :reddit_account

      t.timestamps null: false
    end

    create_table :youtube_channels, id: false do |t|
      t.string :id
      t.string :name
      t.string :username

      t.index :id, unique: true

      t.timestamps null: false
    end
    execute "ALTER TABLE youtube_channels ADD PRIMARY KEY (id);"

    create_table :channel_assignments do |t|
      t.belongs_to :subreddit, index: true
      t.string     :youtube_channel_id, index: true
      t.string     :regexp

      t.timestamps null: false
    end
  end
end
