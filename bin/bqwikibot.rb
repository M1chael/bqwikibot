#!/usr/bin/env ruby

require 'yaml'

wd = File.expand_path(File.dirname(__FILE__))
Dir["#{wd}/../lib/*.rb"].each {|file| require file }
pages = Hash.new
config = YAML.load_file(wd + '/../assets/config.yml')
wiki = Wiki.new(uri: 'https://bq.miraheze.org/w/api.php', 
    login: config[:login], password: config[:password])

config[:updates].each do |device, data|
  pages[device] = Array.new
  data.each do |type, addr|
    pages[device] << Parser.new(type: type, page: WebPage.new(type => addr).html)
  end
end

pages.each do |device, data|
  data.each do |page|
    wiki.update(page: device, type: page.type, data: page.data)
  end
end
