class AddRedditAccounts < ActiveRecord::Migration
  create_table :reddit_accounts do |t|
    t.string  :username
    t.string  :password_var

    t.timestamps null: false
  end
end
