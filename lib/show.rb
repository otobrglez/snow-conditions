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

  class ParsingError < StandardError; end;

  def self.state
    begin
      elements = get("/snegraz.html").xpath("//td[@class='vsebina']/p")
      SnowInformation.new(elements[0].text, elements[2].text, elements[3].text)
    rescue StandardError => error
      raise ParsingError, "Error parsing data from page"
    end
  end

end

SnowInformation = Struct.new(:date, :level, :details) do

  def date
    @date ||= Date.parse(self[:date])
  end

  def sha
    @sha ||= Digest::SHA1.hexdigest (values * "-")
  end

end

