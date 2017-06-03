require_relative '../lib/webpage.rb'
require_relative 'spec_helper.rb'

describe WebPage do

	let(:commentators) { WebPage.new(commentators: 775878) }
  let(:reviews) { WebPage.new(reviews: 'bq_aquaris_u_lite') }

	describe '#type' do
		it 'returns type of page' do
			expect(commentators.type).to eq(:commentators)
		end
	end

  describe '#html' do
    it 'returns content of commentators page' do
      expect(commentators.html.xpath('//div[@class="borderwrap"]/div[@class="maintitle"]').text).
        to eq('Кто писал сообщения в: BQ Aquaris U Lite - Обсуждение')
    end

    it 'returns content of reviews page' do
      expect(reviews.html.xpath('//*[@id="comments"]/div[2]/div[1]/div[1]').text).
        to eq('ОБЩАЯ ОЦЕНКА')
    end
  end

end
