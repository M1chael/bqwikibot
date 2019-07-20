require 'nokogiri'

class Parser

	attr_reader :type, :data

	def initialize(options)
    @data = Array.new
    @type = options[:type]
    parse(options[:page])
	end

  private

  def parse(page)
    if @type == :reviews
      @data << Hash.new
      @data[0][:rating] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[2]/div[1]').text.to_i
      @data[0][:count] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[3]').text.split(' ')[-1].to_i
    else
      count(page.css('div.post_header'))
    end
  end

  def count(divs)
    @total = 0
    @user_id = 0
    divs.each do |div|
      @data << Hash.new
      @data[@user_id][:name] = div.text[0, div.text.rindex(' ')].strip
      @data[@user_id][:count] = div.text.split[-1].to_i
      @total += @data[@user_id][:count]
      @user_id += 1
    end

    @data.each do |data|
      data[:pct] = (data[:count].to_f * 100 / @total).round
    end
    @data = @data.sort_by { |user| user[:count] }.reverse[0..4]
  end

end
