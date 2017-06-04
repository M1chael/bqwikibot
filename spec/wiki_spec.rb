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
		it 'updates rating' do
      expect(wiki_lib).to receive(:get_text).with('page_name').and_return(File.read('test/U_Lite_wiki.txt'))
      expect(wiki_lib).to receive(:edit).with('page_name', File.read('test/U_Lite_wiki_rating.txt'), minor = false, bot = true, summary = 'Обновление количества отзывов на 4PDA')
      wiki = Wiki.new(uri: 'htttp://wiki.test/w/api.php', login: 'login', password: 'pass')
      wiki.update(page: 'page_name', type: :reviews, data: {rating: 7, count: 6})
		end
	end

end
