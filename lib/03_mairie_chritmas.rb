# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_array_city_links(page)
  # page.xpath('//a[@class="lientxt"]/@href')

  url = 'http://annuaire-des-mairies.com/'
  city_links = page.css('a.lientxt') # [0]['href']
  array_city_links = []
  city_links.each do |x|
    link = x['href']
    array_city_links << url + link[2..-1]
  end
  array_city_links
end

def get_array_city_name(page)
  city_name = page.xpath('//a[@class="lientxt"]')

  array_city_name = []

  city_name.each { |city| array_city_name << city.text }

  array_city_name
end

def get_array_of_cities_email(page)
  array_city_link = get_array_city_links(page)

  array_cities_email = []
  array_city_link.each do |x|
    city_page = Nokogiri::HTML(URI.open(x))
    array_cities_email << city_page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  array_cities_email
end

def hash_cities_email(array_city_link, array_cities_email)
  size = array_cities_email.size
  cities_array = []
  size.times do |cpt|
    hash = { array_city_link[cpt] => array_cities_email[cpt] }
    # hash[crypto_syb[cpt].text] = crypto_price[cpt].text
    cities_array << hash
  end
  cities_array
end

def perform
  page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))

  array_city_name = get_array_city_name(page)
  array_cities_email = get_array_of_cities_email(page)
  hash_cities_email(array_city_name, array_cities_email)
end

puts perform
# city_page = Nokogiri::HTML(URI.open(array_city_link[0]))
# puts city_page.xpath('//main/section[2]').text
