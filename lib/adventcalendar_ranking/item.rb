# frozen_string_literal: true

require 'open-uri'
require 'uri'

class AdventcalendarRanking::Item
  extend Memoist
  include Virtus.model

  attribute :author, String
  attribute :title,  String
  attribute :url,    String

  def posted?
    !!url
  end

  memoize def hatena_bookmark_count
    return unless posted?
    endpoint = "http://api.b.st-hatena.com/entry.count?url=#{URI.encode_www_form_component(url)}"
    open(endpoint).read.to_i
  end
end
