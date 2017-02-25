data = YAML::load(File.open('data.yaml'))

data[:reddits].each do |reddit_name, reddit|
  ras = RedditAccount.where(username: reddit[:account_info][:username])
  if !ras.first
    ra = RedditAccount.new(
      username: reddit[:account_info][:username],
      password_var: reddit[:account_info][:password_var]
    )
    ra.save!
  else
    ra = ras.first
  end

  sr = Subreddit.create(
    name: reddit_name.to_s,
    account: ra
  )

  reddit[:channels].each do |channel_username, channel|
    assignment = sr.channel_assignments.build
    assignment.regexp = channel[:regexp]

    yt_channel_data = YouTube.youtube_channel_data(username: channel_username.to_s)
    ytc = YoutubeChannel.find_or_create_by(
      id: yt_channel_data[:id],
      username: channel_username.to_s,
      name: yt_channel_data[:name]
    )
    assignment.channel = ytc

    channel[:recents].each do |recent|
      recent["published_at"] = DateTime.iso8601(recent["published_at"])
      recent.delete("url")
      vid = YoutubeVideo.new(
        recent
      )
      unless YoutubeVideo.exists? vid.id
        vid.save!
        ytc.videos << vid
      end

      vid = YoutubeVideo.find(vid.id)
      post = RedditPost.create(
        video: vid,
        subreddit: sr
      )
    end

    ytc.save!
    sr.save!
  end

end
