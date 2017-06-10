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
      count(page.xpath('/html/body/div/table'))
    end
  end

  def count(table)
    @total = 0
    @user_id = 0
    table.search('tr').each do |tr|
      tr.search('td').each do |td|
        if td['align'] == 'left'
          @user = td.search('a').text
          @data << Hash.new
          @data[@user_id][:name] = @user
        else
          @data[@user_id][:count] = td.text.to_i
          @user_id += 1
          @total += td.text.to_i
        end
      end
    end
    @data.each do |data|
      data[:pct] = (data[:count].to_f * 100 / @total).round
    end
    @data = @data.sort_by { |user| user[:count] }.reverse[0..4]
  end

end
