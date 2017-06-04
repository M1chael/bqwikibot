require 'mediawiki/butt'

class Wiki

  def initialize(options)
    @wiki = MediaWiki::Butt.new(options[:uri])
    @wiki.login(options[:login], options[:password])
  end

  def update(options)
    # options[:page], options[:type], options[:data]
    regexs = { reviews: /(.*''')(\d{1,2})(\/10''' \()(\d*)( отзывов\)<.*)/ }
    text = @wiki.get_text(options[:page])
    if match = text.match(regexs[:reviews])
      if match[2] != options[:data][:rating] || match[4] != options[:data][:rating]
        @wiki.edit(options[:page], 
          text.gsub(regexs[:reviews], "\\1#{options[:data][:rating]}\\3#{options[:data][:count]}\\5"), 
          minor = false, bot = true, summary = 'Обновление количества отзывов на 4PDA')
      end
    end
  end

end
