# frozen_string_literal: true
require 'open-uri'
require_relative './item'

class AdventcalendarRanking::Scraper
  include Virtus.model

  attribute :year, Integer, default: ENV['AR_YEAR']
  attribute :code, String,  default: ENV['AR_CODE']

  def run!
    items
  end

  private

  def document
    @document ||= Nokogiri::HTML(open("http://qiita.com/advent-calendar/#{year}/#{code}"))
  end

  def calendar_item_elements
    @calendar_item_elements ||= document.xpath('//*[@id="main"]/div/div/div/div[@class="adventCalendarItem"]')
  end

  def items
    @items ||= calendar_item_elements.map { |elem| item_from_element(elem) }
  end

  def item_from_element(elem)
    title, url = title_and_url(elem)

    AdventcalendarRanking::Item.new(
      author: author(elem),
      title:  title,
      url:    url,
    )
  end

  def author(elem)
    elem.xpath('div[@class="adventCalendarItem_author"]/a/img').attr('alt').value
  end

  def title_and_url(elem)
    if !elem.xpath('div[@class="adventCalendarItem_entry"]').empty?
      link = elem.xpath('div[@class="adventCalendarItem_entry"]/a')
      [link.text.chomp, link.attr('href').value]
    else
      [elem.xpath('div[@class="adventCalendarItem_comment"]').text.chomp, nil]
    end
  end
end
