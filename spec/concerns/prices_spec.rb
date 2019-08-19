# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prices do
  describe '#net_price' do
    it 'calculates correct net price' do
      expect(described_class.net_price(2137)).to eq(1737.4)
    end
  end

  describe '#formatted_price' do
    describe 'returns price with precision of 2 with uppercase currency' do
      subject { described_class.formatted_price(21.37, 'xbc') }

      it { is_expected.to match('21.37') }
      it { is_expected.to match(/XBC$/) }
      it { is_expected.to match('&nbsp;') }
    end

    context 'with net: true' do
      describe 'returns net price with precision of 2 with uppercase currency' do
        subject { described_class.formatted_price(26.29, 'twd', net: true) }

        it { is_expected.to match('21.37') }
        it { is_expected.to match(/TWD$/) }
        it { is_expected.to match('&nbsp;') }
      end
    end
  end

  describe '#formatted_prices' do
    describe 'returns prices in PLN and EUR with separator' do
      subject { described_class.formatted_prices(21.37, 6.9) }

      it { is_expected.to match('21.37&nbsp;PLN') }
      it { is_expected.to match('6.90&nbsp;EUR') }
      it { is_expected.to match(Prices::PRICE_SEPARATOR) }
    end

    context 'with net: true' do
      describe 'returns net prices in PLN and EUR' do
        subject { described_class.formatted_prices(123, 6.15, net: true) }

        it { is_expected.to match('100.00&nbsp;PLN') }
        it { is_expected.to match('5.00&nbsp;EUR') }
        it { is_expected.to match(Prices::PRICE_SEPARATOR) }
      end
    end
  end

  describe '#discount/2' do
    context 'when total <= balance' do
      it 'returns total' do
        actual = described_class.discount(10, 20)
        expect(actual).to eq(10)
      end
    end

    context 'when total > balance' do
      it 'returns balance' do
        actual = described_class.discount(40, 15)
        expect(actual).to eq(15)
      end
    end
  end
end
