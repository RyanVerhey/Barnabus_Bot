class AddRedditPostJoinTable < ActiveRecord::Migration
  def change
    create_table :reddit_posts do |t|
      t.string     :video_id,  index: true
      t.belongs_to :subreddit, index: true

      t.timestamps null: false
    end
  end
end
