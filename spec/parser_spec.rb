require_relative '../lib/parser.rb'
require_relative 'spec_helper.rb'

describe Parser do

	let(:commentators) { Parser.new(type: :commentators, 
    page: Nokogiri::HTML(open('test/U_Lite_commentators2.html'))) }
  let(:reviews) { Parser.new(type: :reviews, 
    page: Nokogiri::HTML(open('test/U_Lite_reviews.html'))) }

	describe '#type' do
		it 'returns type of data' do
			expect(commentators.type).to eq(:commentators)
		end
	end

  describe '#data' do
    it 'returns reviews rating' do
      expect(reviews.data[0][:rating]).to eq(8)
    end

    it 'returns reviews count' do
      expect(reviews.data[0][:count]).to eq(7)
    end

    it 'returns commentators stat' do
      expect(commentators.data).to match_array(COMMENTATORS)
    end
  end

end
