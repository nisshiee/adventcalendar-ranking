# frozen_string_literal: true

module AdventcalendarRanking
  def self.run!
    items = AdventcalendarRanking::Scraper.new.run!
    ranking = AdventcalendarRanking::Ranking.new(items: items)
    AdventcalendarRanking::SlackPost.new(ranking: ranking).run!
  end
end

require_relative './adventcalendar_ranking/scraper'
require_relative './adventcalendar_ranking/ranking'
require_relative './adventcalendar_ranking/slack_post'
