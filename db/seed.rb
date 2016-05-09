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

  sr = Subreddit.new(
    name: reddit_name.to_s,
    reddit_account: ra
  )

  reddit[:channels].each do |channel_name, channel|
    ytc = YoutubeChannel.new(
      name: channel_name.to_s,
      regexp: channel[:regexp]
    )

    channel[:recents].each do |recent|
      recent["published_at"] = DateTime.iso8601(recent["published_at"])
      vid = Video.new(
        recent
      )
      unless Video.exists? vid.id
        vid.save!
        ytc.videos << vid
      end
    end

    ytc.save!
    sr.youtube_channels << ytc
    sr.save!
  end

end
