# FR Spam Blocker

Blocks some stupid spam messages on Twitter ([examples](https://gist.github.com/matiaskorhonen/ea5e5774e940b47be06e)).


## Running on Heroku

Set these environment variables with `heroku config:set` (you'll need a write-capable Twitter app and it's credentials):

* `chatterbot_consumer_key`
* `chatterbot_consumer_secret`
* `chatterbot_token`
* `chatterbot_secret`

To run the script you have two options:

1. **Use the streaming mode**
  * Start the `chatterbot` dyno: `heroku ps:scale chatterbot=1`
2. **Run it with the Heroku Scheduler**
  * Add `bundle exec ./bot.rb` to the scheduler
