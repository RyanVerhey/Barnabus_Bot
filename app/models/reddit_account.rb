class RedditAccount < ActiveRecord::Base
  has_many :subreddits
  attr_accessor :password

  after_initialize do
    self.password = ENV[self.password_var]
  end
end
