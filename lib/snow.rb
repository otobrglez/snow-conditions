# coding: UTF-8
# encoding: UTF-8

require "httparty"
require "nokogiri"
require 'digest/sha1'
require "redis"
require_relative "pushover"
require_relative "snow_information"

class HtmlParserIncluded < HTTParty::Parser
  SupportedFormats.merge!('text/html' => :html)

  def html; Nokogiri::HTML(body); end
end

class Snow
  include HTTParty
  parser HtmlParserIncluded
  base_uri 'http://www.arso.gov.si/vreme/napovedi%20in%20podatki'

  class ParsingError < StandardError; end;

  class << self

    def redis
      @@redis ||= begin
        uri = URI.parse(ENV["REDIS_URL"] || ENV["REDISTOGO_URL"])
        Redis.new(host: uri.host, port: uri.port, password: uri.password)
      end
    end

    def pushover
      @@pushover ||= begin
        Pushover.new
      end
    end

    def state
      begin
        elements = get("/snegraz.html").xpath("//td[@class='vsebina']/p")
        SnowInformation.new(elements[0].text, elements[2].text, elements[3].text)
      rescue StandardError => error
        raise ParsingError, "Error parsing"
      end
    end

    def process
      info = state

      unless redis.exists info.key
        redis.set info.key, info.value #, {ex: 604800} # 7 days
        notify info
      end

      info
    end

    def notify info

      pushover.push(info.level, {
        title: "Snežne razmere",
        url_title: "Snežne razmere #{info.date}",
        url: "http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html"
      }) unless ENV["COND_ENV"]=="test"

    end

  end
end
