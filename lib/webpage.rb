require 'nokogiri'
require 'net/http'
require 'open-uri'

class WebPage

	attr_reader :type, :html

	def initialize(options)
    types = { commentators: 'http://4pda.ru/forum/index.php?act=Stats&view=who&t=<param>', 
    reviews: 'http://4pda.ru/devdb/<param>' }
    @type = options.keys[0]
    @html = Nokogiri::HTML(URI.open(types[@type].sub('<param>', options.values[0].to_s), 
      'User-Agent' => 'BQ wiki bot'))
	end
end
