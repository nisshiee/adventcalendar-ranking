# frozen_string_literal: true
namespace :adventcalendar_ranking do
  task run: :require do
    AdventcalendarRanking.run!
  end
end
