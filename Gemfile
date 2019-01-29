# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.4'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'combine_popolo_memberships', github: 'everypolitician/combine_popolo_memberships'
gem 'execjs'
gem 'nokogiri'
gem 'open-uri-cached'
gem 'rake'
gem 'rest-client'
gem 'rubocop'
gem 'scraped', github: 'everypolitician/scraped', branch: 'scraper-class'
gem 'scraped_page_archive', github: 'everypolitician/scraped_page_archive'
gem 'scraper_test', github: 'everypolitician/scraper_test'
gem 'scraperwiki', github: 'openaustralia/scraperwiki-ruby',
                   branch: 'morph_defaults'
gem 'table_unspanner', github: 'everypolitician/table_unspanner'
gem 'wikidata-fetcher', github: 'everypolitician/wikidata-fetcher'
gem 'wikidata_ids_decorator', github: 'everypolitician/wikidata_ids_decorator'

group :test do
  gem 'minitest'
  gem 'minitest-around'
  gem 'minitest-vcr'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'pry'
end
