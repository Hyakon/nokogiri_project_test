# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def display_each_text(crypto)
  crypto.each do |i|
    puts i.text
  end
end

def hash_crypto(crypto_syb, crypto_price)
  size = crypto_syb.size
  crypto_array = []
  size.times do |cpt|
    hash = { crypto_syb[cpt].text => crypto_price[cpt].text }
    # hash[crypto_syb[cpt].text] = crypto_price[cpt].text
    crypto_array << hash
  end
  crypto_array
end

page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
# puts page.xpath('//tbody/tr/td[2]/div').text # css('span.cmc-link').text  # => Nokogiri::HTML::Document
# crypto_syb_xpath = page.xpath('//tbody/tr/td[3]/div')

# crypto_name = page.css('tbody tr td[2] div a')
crypto_syb = page.css('tbody tr td[3] div')
crypto_price = page.css('tbody tr td[5] a')

# puts crypto_name.text

# puts crypto_syb

puts hash_crypto(crypto_syb, crypto_price)
