# coding: UTF-8
# encoding: UTF-8

require "httparty"
require "nokogiri"
require 'digest/sha1'

class HtmlParserIncluded < HTTParty::Parser
  SupportedFormats.merge!('text/html' => :html)

  def html; Nokogiri::HTML(body); end
end

class Snow
  include HTTParty
  parser HtmlParserIncluded

  base_uri 'http://www.arso.gov.si/vreme/napovedi%20in%20podatki'

  def self.state
    begin
      elements = get("/snegraz.html").xpath("//td[@class='vsebina']/p")

      SnowInformation.new(elements[0].text, elements[2].text, elements[3].text)

    rescue
      raise SnowParsingError("Error parsing data from page")
    end
  end

  class SnowParsingError < StandardError; end;
end

SnowInformation = Struct.new(:date, :level, :details) do

  def date
    @date ||= Date.parse(self[:date])
  end

  def sha
    @sha ||= Digest::SHA1.hexdigest (values * "-")
  end

end

