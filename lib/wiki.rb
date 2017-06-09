require 'mediawiki/butt'

class Wiki

  def initialize(options)
    @wiki = MediaWiki::Butt.new(options[:uri])
    @wiki.login(options[:login], options[:password])
  end

  def update(options)
    data_str = Array.new
    options[:data].each{ |data| data_str << data.map { |k, v| [k, v.to_s] }.to_h }
    regexs = {reviews: /(.*''')(\d{1,2})(\/10''' \()(\d*)( отзывов\)<.*)/,
      commentators: /(.*{\| class=\\"wikitable\\"\\n!Пользователь\\n!Сообщений\\n!Доля\\n\|-\\n\|)([^\\]*)(\\n\|)(\d*)(\\n\|)(\d*)(%\\n\|-\\n\|)([^\\]*)(\\n\|)(\d*)(\\n\|)(\d*)(%\\n\|-\\n\|)([^\\]*)(\\n\|)(\d*)(\\n\|)(\d*)(%\\n\|-\\n\|)([^\\]*)(\\n\|)(\d*)(\\n\|)(\d*)(%\\n\|-\\n\|)([^\\]*)(\\n\|)(\d*)(\\n\|)(\d*)(%\\n\|}.*)/
    }
    summaries = {reviews: 'Обновление статистики отзывов на 4PDA', 
      commentators: 'Обновление статистики комментариев на 4PDA'}
    text = @wiki.get_text(options[:page])
    if match = text.match(regexs[options[:type]])
      matches = Array.new
      substring = ''
      data_str.each_with_index do |data, ind|
        matches << Hash.new
        (6*ind+2..6*ind+data.size*2).step(2) do |index|
          matches[-1][data.keys[(index-6*ind)/2-1]] = match[index]
          substring += "#{match[index-1]}#{data[data.keys[(index-6*ind)/2-1]]}"
        end
      end
      substring += "#{match[data_str[0].size*data_str.size*2+1]}"
      compare = matches-data_str
      if compare.size != 0
          @wiki.edit(options[:page], 
            text.gsub(regexs[options[:type]], substring), 
            minor = false, bot = true, summary = summaries[options[:type]])
      end
    end
  end

end
