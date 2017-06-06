require 'mediawiki/butt'

class Wiki

  def initialize(options)
    @wiki = MediaWiki::Butt.new(options[:uri])
    @wiki.login(options[:login], options[:password])
  end

  def update(options)
    regexs = { reviews: /(.*''')(\d{1,2})(\/10''' \()(\d*)( отзывов\)<.*)/ }
    text = @wiki.get_text(options[:page])
    if match = text.match(regexs[:reviews])
      if match[2].to_i != options[:data][:rating] || match[4].to_i != options[:data][:count]
        @wiki.edit(options[:page], 
          text.gsub(regexs[:reviews], "\\1#{options[:data][:rating]}\\3#{options[:data][:count]}\\5"), 
          minor = false, bot = true, summary = 'Обновление статистики отзывов на 4PDA')
      end
    end
  end

end
