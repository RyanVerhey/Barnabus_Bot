class AddTagsToSubreddits < ActiveRecord::Migration
  def change
    add_column :subreddits, :tags, :text
  end
end
