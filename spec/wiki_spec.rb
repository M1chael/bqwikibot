require_relative '../lib/wiki.rb'
require_relative 'spec_helper.rb'

describe Wiki do

  let(:wiki_lib) { double }
  before(:example) do
    allow(MediaWiki::Butt).to receive(:new).and_return(wiki_lib)
    allow(wiki_lib).to receive(:login)
  end

  describe '#new' do
    it 'authenticates' do
      expect(MediaWiki::Butt).to receive(:new).with('htttp://wiki.test/w/api.php').and_return(wiki_lib)
      expect(wiki_lib).to receive(:login).with('login', 'pass')
      Wiki.new(uri: 'htttp://wiki.test/w/api.php', 
    login: 'login', password: 'pass')
    end
  end

	describe '#update' do
    before(:example) do
      @wiki = Wiki.new(uri: 'htttp://wiki.test/w/api.php', login: 'login', password: 'pass')
      allow(wiki_lib).to receive(:get_text).with('page_name').and_return(File.read('test/U_Lite_wiki.txt'))
    end

		it 'updates rating' do
      expect(wiki_lib).to receive(:edit).with('page_name', File.read('test/U_Lite_wiki_rating.txt'), 
        minor = false, bot = true, summary = 'Обновление статистики отзывов на 4PDA')
      @wiki.update(page: 'page_name', type: :reviews, data: {rating: 7, count: 6})
		end

    it 'updates count' do
      expect(wiki_lib).to receive(:edit).with('page_name', File.read('test/U_Lite_wiki_reviews.txt'), 
        minor = false, bot = true, summary = 'Обновление статистики отзывов на 4PDA')
      @wiki.update(page: 'page_name', type: :reviews, data: {rating: 9, count: 7})      
    end

    it 'updates rating and count' do
      expect(wiki_lib).to receive(:edit).with('page_name', File.read('test/U_Lite_wiki_rating_reviews.txt'), 
        minor = false, bot = true, summary = 'Обновление статистики отзывов на 4PDA')
      @wiki.update(page: 'page_name', type: :reviews, data: {rating: 7, count: 7})          
    end

    it 'doesn\'t update' do
      expect(wiki_lib).not_to receive(:edit)
      @wiki.update(page: 'page_name', type: :reviews, data: {rating: 9, count: 6})  
    end
	end

end
