# frozen_string_literal: true

require 'net/http'
require 'erb'
require_relative './ranking'

class AdventcalendarRanking::SlackPost
  include Virtus.model

  attribute :ranking, AdventcalendarRanking::Ranking

  attribute :year, Integer,      default: ENV['AR_YEAR']
  attribute :name, String,       default: ENV['AR_NAME']
  attribute :code, String,       default: ENV['AR_CODE']
  attribute :slack_path, String, default: ENV['AR_SLACK_PATH']

  def run!
    http = Net::HTTP.new('hooks.slack.com', Net::HTTP.https_default_port)
    http.use_ssl = true
    http.post(
      slack_path,
      body,
    )
  end

  private

  def body
    body_hash.to_json
  end

  def body_hash
    {
      username:   "#{name}アドベントカレンダー#{year}記事ランキング",
      icon_emoji: ':tada:',
      attachments: [
        {
          color: '#66AE33',
          title: "#{Time.now.day}日のはてブ数速報",
          title_link: "http://qiita.com/advent-calendar/#{year}/#{code}",
          text: text,
        },
      ],
    }
  end

  def text
    erb = ERB.new(open(File.expand_path('../slack_post/text.erb', __FILE__)).read)
    Struct.new(:ranking).new(ranking).instance_eval do
      erb.result(binding)
    end
  end
end
