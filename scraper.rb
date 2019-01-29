#!/bin/env ruby
# frozen_string_literal: true

require 'pry'
require 'scraped'
require 'scraperwiki'
require 'wikidata_ids_decorator'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

class MembersPage < Scraped::HTML
  decorator WikidataIdsDecorator::Links

  field :members do
    members_table.flat_map do |table|
      table.xpath('.//tr[td]').map { |tr| data = fragment(tr => MemberRow).to_h }
    end
  end

  private

  def members_table
    noko.xpath('//h3[span[@id="Elected_members"]]/following-sibling::table[1]')
  end
end

class MemberRow < Scraped::HTML
  field :name do
    name_node.text.tidy
  end

  field :id do
    '14-%s' % tds[0].text.tidy
  end

  field :area do
    tds[1].text.tidy
  end

  field :area_id do
    tds[0].text.tidy
  end

  field :term do
    13
  end

  field :wikidata do
    tds[2].xpath('.//a/@wikidata').text
  end

  field :source do
    url
  end

  private

  def tds
    noko.css('td')
  end

  def name_node
    tds[2].at_css('a') || tds[2].xpath('text()')
  end
end

url = 'https://en.wikipedia.org/wiki/North_Korean_parliamentary_election,_2014'
Scraped::Scraper.new(url => MembersPage).store(:members, index: %i[name area_id])
