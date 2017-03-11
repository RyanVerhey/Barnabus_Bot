class AddIndexToRedditPosts < ActiveRecord::Migration
  def change
    add_index :reddit_posts, :video_id
    add_index :reddit_posts, :subreddit_id
  end
end
