# frozen_string_literal: true

class AdventcalendarRanking::Ranking
  extend Memoist
  include Virtus.model
  include Enumerable

  attribute :items, Array[AdventcalendarRanking::Item]

  memoize def posted_items
    items.select(&:posted?)
  end

  memoize def order
    posted_items.sort_by { |i| -i.hatena_bookmark_count }
  end

  def each(&block)
    order.each(&block)
  end
end
