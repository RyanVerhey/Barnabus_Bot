Barnabus_Bot
============

Auto-posting bot for the [/r/YogscastKim](http://reddit.com/r/yogscastkim) subreddit. Posts videos from the YogscastKim YouTube and Twitch channels, as well as videos that feature Kim, to the subreddit.

#### New in version 3!
Wow! This is a big release.

###### Twitch Integration
VODs from Twitch channels can be posted to Reddit now!

###### Lots of under-the-hood changes
* Everything is now saved in a MySQL database
* Massive refactoring changes, no file was left unchanged
* There were some changes made to the Reddit posting API, so those changes were integrated
* Tried to go for an [MVC](https://en.wikipedia.org/wiki/Model–view–controller) feel, although in this case it's just MC

###### Helpful formatting tips
Adding subreddits `.yml` formatting:
```yml
subreddit:
  name: subreddit_name
  reddit_account:
    name: reddit_account_to_use
    password_var: VAR
  tags:
    match:
      "Title regexp": "[Tag]"
      "(another|regexp)": "[Spoiler!]"
    default: "[No Spoilers]"
  channels:
  - username: channel_1
    regexp: '.+'
    type: youtube
  - username: channel_2
    regexp: 'string'
    type: youtube
```

Adding channels `.yml` formatting:
```yml
channels:
  - name: channel_username
    regexp: '.+'
    type: twitch
  - name: other_channel_username
    regexp: '\sother'
    type: youtube
```
