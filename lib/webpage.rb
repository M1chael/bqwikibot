require 'nokogiri'
require 'net/http'

class WebPage

	attr_reader :type, :html

  TYPES = { commentators: 'http://4pda.ru/forum/index.php?act=Stats&view=who&t=<param>' }

	def initialize(options)
    @type = options.keys[0]
    get_content(options.values[0])
	end

  private

  def get_content(param)
    uri = make_uri(param)
    http = Net::HTTP.new(uri.host, 80)
req = Net::HTTP::Get.new(uri, {'User-Agent' => 'BQ wiki bot'})
@html = Nokogiri::HTML(http.request(req).body)
# @ response.body
    # @html = Nokogiri::HTML(Net::HTTP.get(URI(TYPES[@type].sub('<param>', param.to_s)), {'User-Agent' => 'BQ wiki bot'}))
  end

  def make_uri(param)
    URI(TYPES[@type].sub('<param>', param.to_s))
  end

end
