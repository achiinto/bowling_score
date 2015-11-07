require 'spec_helper'

describe BowlingScore do
  describe 'Constant NUMBER_OF_PINS' do
    it 'returns 10' do
      expect(described_class::NUMBER_OF_PINS).to eq 10
    end
  end

  describe 'Constant NUMBER_OF_STRIKE_REWARD' do
    it 'returns 2' do
      expect(described_class::NUMBER_OF_STRIKE_REWARD).to eq 2
    end
  end

  describe 'Constant NUMBER_OF_SPARE_REWARD' do
    it 'returns 1' do
      expect(described_class::NUMBER_OF_SPARE_REWARD).to eq 1
    end
  end

  describe 'Constant NUMBER_OF_FRAME' do
    it 'returns 10' do
      expect(described_class::NUMBER_OF_FRAME).to eq 10
    end
  end
end
