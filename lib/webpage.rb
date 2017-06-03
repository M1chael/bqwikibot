require 'nokogiri'
require 'net/http'

class WebPage

	attr_reader :type, :html

  TYPES = { commentators: 'http://4pda.ru/forum/index.php?act=Stats&view=who&t=<param>', 
    reviews: 'http://4pda.ru/devdb/<param>' }

	def initialize(options)
    @type = options.keys[0]
    get_content(options.values[0])
	end

  private

  def get_content(param)
    uri = URI(TYPES[@type].sub('<param>', param.to_s))
    http = Net::HTTP.new(uri.host, 80)
    req = Net::HTTP::Get.new(uri, {'User-Agent' => 'BQ wiki bot'})
    @html = Nokogiri::HTML(http.request(req).body)
  end

end
