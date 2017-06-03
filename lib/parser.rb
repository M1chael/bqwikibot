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
    if @type == :reviews
      @data[:rating] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[2]/div[1]').text.to_i
      @data[:count] = page.xpath('//*[@id="comments"]/div[2]/div[1]/div[3]').text.split(' ')[-1].to_i
    else
      count(page.xpath('/html/body/div/table'))
    end
  end

  def count(table)
    @total = 0
    table.search('tr').each do |tr|
      tr.search('td').each do |td|
        if td['align'] == 'left'
          @user = td.search('a').text
          @data[@user] = Hash.new
        else
          @data[@user][:count] = td.text.to_i
          @total += td.text.to_i
        end
      end
    end
    @data.each do |user, data|
      @data[user][:pct] = (data[:count].to_f * 100 / @total).round
    end
    @data = @data.sort_by { |user, data| data[:count] }.reverse[0..4].to_h
  end

end
