#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'scraped'
require 'scraperwiki'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

def noko_for(url)
  Nokogiri::HTML(open(url).read)
end

def scrape_list(url)
  noko = noko_for(url)
  noko.xpath('//h3[span[@id="Elected_members"]]/following-sibling::table[1]//tr[td]').each do |tr|
    tds = tr.css('td')
    data = {
      id:       '14-%s' % tds[0].text.tidy,
      name:     tds[2].css('a').text.tidy,
      area_id:  tds[0].text.tidy,
      area:     tds[1].text.tidy,
      wikiname: tds[2].xpath('.//a[not(@class="new")]/@title').text,
      term:     13,
      source:   url,
    }
    puts data.reject { |_, v| v.to_s.empty? }.sort_by { |k, _| k }.to_h if ENV['MORPH_DEBUG']
    ScraperWiki.save_sqlite(%i(id term), data)
  end
end

ScraperWiki.sqliteexecute('DROP TABLE data') rescue nil
scrape_list('https://en.wikipedia.org/wiki/North_Korean_parliamentary_election,_2014')
