require 'nokogiri'

class Parser

	attr_reader :type, :data

	def initialize(options)
    @data = Hash.new
    @type = options[:type]
    parse(options[:page])
	end

  private

  def parse(page)
    @data[:rating] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[2]/div[1]').text
    @data[:count] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[3]').text.split(' ')[-1]
  end

end
