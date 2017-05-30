#!/usr/bin/env ruby
# encoding: utf-8

require 'mediawiki/butt'
require 'logger'
require 'yaml'
# require_relative '../lib/bot.rb'

# @bot = Bot.new('assets/config.yml')
# DB = Sequel.sqlite('assets/bot.db')

# begin
#   Telegram::Bot::Client.run(@bot.token) do |telegram|
#     @bot.telegram = telegram
#     telegram.listen do |message|
#       @bot.read(message)
#     end
#   end
# rescue => error
#   @bot.logger.fatal(error)
# end

wiki = MediaWiki::Butt.new('https://bq.miraheze.org/w/api.php')
config = YAML.load_file('assets/config.yml')
wiki.login(config[:login], config[:password])
page_text = wiki.get_text('X_Pro')
# p page_text.sub('Источники', 'Цветочники')
# wiki.edit('X_Pro', page_text.sub('Источники', 'Цветочники'), minor = false, bot = true, summary = 'Тестовая ботоправка')


# ===============================

# U_Lite

# http://4pda.ru/forum/index.php?act=Stats&view=who&t=775878

# По состоянию на 06.04.2017 рейтинг — '''9/10''' (6 отзывов)<ref>[http://4pda.ru/devdb/bq_aquaris_u_lite#comments Отзывы] на 4PDA</ref>
