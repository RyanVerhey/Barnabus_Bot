class PostToReddit

  def self.post(videos, reddit_client)
    video_to_post = videos.first
    if video_to_post
      response = reddit_client.submit(video_to_post.title, video_to_post.url, "GildedGrizzly")
      # response = response = reddit_client.submit("Test Title 2", "https://www.youtube.com/watch?v=Qpty3oPS55k", "GildedGrizzly")
      if !response["json"]["errors"].first
        YouTube.save_video_data(video_to_post)
        puts "Video posted! #{response["json"]["data"]["url"]}"
      else
        puts "Something went wrong. Response: #{response}"
      end
    else
      puts "No new video to post"
    end

  end

end
