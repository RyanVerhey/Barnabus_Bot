class AddIndexToRedditPosts < ActiveRecord::Migration
  def change
    add_index :reddit_posts, :subreddit_id
  end
end
