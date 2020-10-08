# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_array_name(page)
  deputy_name = page.xpath('//div[@id="deputes-list"]/div/ul/li/a')

  # puts deputy_name

  array_deputy_name = []

  deputy_name.each { |deputy| array_deputy_name << deputy.text }

  array_deputy_name
end

def get_array_url(page)
  url_base = 'http://www2.assemblee-nationale.fr/'
  url = page.xpath('//div[@id="deputes-list"]/div/ul/li/a')

  array_url = []

  url.each { |deputy| array_url << url_base + deputy['href'] }

  array_url
end

def get_array_of_deputy_email(page)
  array_deputy_link = get_array_url(page)

  array_deputy_email = []

  # x = array_deputy_link[0]
  # deputy_page = Nokogiri::HTML(URI.open(x))
  #
  # puts deputy_page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text

  array_deputy_link.each do |x|
    deputy_page = Nokogiri::HTML(URI.open(x))
    array_deputy_email << deputy_page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  end
  array_deputy_email
end

def hash_deputy_email(array_deputy_name, array_deputy_email)
  size = array_deputy_email.size
  cities_array = []
  size.times do |cpt|
    hash = { array_deputy_name[cpt] => array_deputy_email[cpt] }
    # hash[crypto_syb[cpt].text] = crypto_price[cpt].text
    cities_array << hash
  end
  cities_array
end

def perform
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  array_deputy_name = get_array_name(page)
  puts array_deputy_name.size
  # array_url = get_array_url(page)
  # puts array_url
  array_deputy_email = get_array_of_deputy_email(page)
  hash_deputy_email(array_deputy_name, array_deputy_email)
end

puts perform
