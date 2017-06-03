require_relative '../lib/parser.rb'
require_relative 'spec_helper.rb'

describe Parser do

	let(:commentators) { Parser.new(type: :commentators, 
    page: Nokogiri::HTML(open('test/U_Lite_commentators.html'))) }
  let(:reviews) { Parser.new(type: :reviews, 
    page: Nokogiri::HTML(open('test/U_Lite_reviews.html'))) }

	describe '#type' do
		it 'returns type of data' do
			expect(commentators.type).to eq(:commentators)
		end
	end

  describe '#data' do
    it 'returns reviews rating' do
      expect(reviews.data[:rating]).to eq('8')
    end

    it 'returns reviews count' do
      expect(reviews.data[:count]).to eq('7')
    end
  end

end
