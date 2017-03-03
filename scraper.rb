#!/bin/env ruby
# encoding: utf-8

require 'nokogiri'
require 'pry'
require 'scraperwiki'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

class String
  def tidy
    self.gsub(/[[:space:]]+/, ' ').strip
  end
end

def noko_for(url)
  Nokogiri::HTML(open(url).read)
end

def scrape_list(url)
  noko = noko_for(url)
  noko.xpath('//h3[span[@id="Elected_members"]]/following-sibling::table[1]//tr[td]').each do |tr|
    tds = tr.css('td')
    const = tds[0].text.tidy,
    data = { 
        id: '14-%s' % tds[0].text.tidy,
        name: tds[2].text.tidy,
        area_id: tds[0].text.tidy,
        area: tds[1].text.tidy,
        wikiname: tds[2].xpath('.//a[not(@class="new")]/@title').text,
        term: 13,
        source: url,
    }
    ScraperWiki.save_sqlite([:id, :term], data)
  end
end

scrape_list('https://en.wikipedia.org/wiki/North_Korean_parliamentary_election,_2014')
