require_relative '../lib/webpage.rb'
require_relative 'spec_helper.rb'

describe WebPage do

	let(:webpage) { WebPage.new(commentators: 775878) }

	describe '#type' do
		it 'returns type of page' do
			expect(webpage.type).to eq(:commentators)
		end
	end

  describe '#html' do
    it 'returns html-content of page' do
      expect(webpage.html.xpath('//div[@class="borderwrap"]/div[@class="maintitle"]').text).
      to eq('Кто писал сообщения в: BQ Aquaris U Lite - Обсуждение')
    end
  end

end
