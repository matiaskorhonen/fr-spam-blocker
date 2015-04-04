#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"

require "chatterbot/dsl"
require "retryable"

#
# this is the script for the twitter bot frozenrails
# generated on 2015-04-03 18:34:43 +0300
#

# remove this to send out tweets
# debug_mode

# remove this to update the db
no_update
# remove this to get less output when running
verbose

# here"s a list of users to ignore
# blacklist "bostonrb", "scotrubyconf"

# here"s a list of things to exclude from searches
# exclude "hi", "spammer", "junk"

# search "keyword" do |tweet|
#  reply "Hey #USER# nice to meet you!", tweet
# end

ensure_cb = Proc.new do |retries|
  puts "Total retry attempts: #{retries}"
end

exception_cb = Proc.new do |exception|
  puts "#{exception.class}: #{exception.message}"
end

replies_block = Proc.new do |tweet|
  replies do |tweet|
    if tweet.user.handle =~ /\A(scotrubyconf)([a-z0-9]+)\z/i
      puts "Found spam: @#{tweet.user.handle}: #{tweet.text}"
      print "Reporting it..."
      client.report_spam(tweet.user) && print(" Done.\n")
    else
      # puts "Innocent tweet by @#{tweet.user.handle}"
    end
  end
end

if ENV["STREAMING"]
  Retryable.retryable(tries: 10, ensure: ensure_cb, exception_cb: exception_cb) do
    streaming &replies_block
  end
else
  replies_block.call
end
