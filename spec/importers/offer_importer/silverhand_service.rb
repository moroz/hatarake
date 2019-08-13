# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SilverhandService do

  describe 'self.root_url' do
    it 'return import root URL' do
      expect(described_class.root_url).to eq 'https://silverhand.eu/jooble.php'
    end
  end

  describe 'self.import' do
    describe 'generally' do
      subject { described_class.import }
      it { is_expected.to be_a(Array) }
    end

    describe 'transform each offer' do
      offer = described_class.import.first
      it 'merge publisher key to offer' do
        expect(offer[:publisher]).to eq 'Silverhand'
      end

      it 'delete locations key' do
        expect(offer[:locations]).to be_nil
      end

      it 'joins country and city with pipe in location field' do
        expect(offer[:location].split('|').size).to eq 2
      end

      it 'extract currency from salary string' do
        expect(offer[:currency].size).to eq 3
      end
    end
  end

  describe 'self.schema' do
    it 'return array with hashes inside' do
      expect(described_class.schema).to include(a_kind_of(Hash))
    end
  end

  describe 'self.extract_currency' do
    context 'euro currency given' do
      it 'return short currency name' do
        expect(described_class.extract_currency('something euro something')).to eq 'eur'
      end
    end

    context 'any upcased short currency name given' do
      it 'return downcased currency name' do
        expect(described_class.extract_currency('smth PLN smth')).to eq 'pln'
      end
    end
  end

  describe 'self.map_salaries' do
    context 'salary ends with "Miesiąc"' do
      # job = { salary: '10,0-20,1 PLN na Miesiąc' }
      # described_class.map_salaries(job)
      # it 'return' do
      #   expect(job[:salary]).to eq '22'
      # end
    end

    context 'salary ends with "Tydzień"' do

    end

    context 'salary ends with "Godzinę"' do

    end
  end

  describe 'self.make_salary_range' do
    context 'there is no range' do
      salary_range = described_class.make_salary_range('10,3 EUR na godzinę')
      it 'first array element' do
        expect(salary_range.first).to be_nil
      end

      it 'second array element' do
        expect(salary_range.second).to eq 10.3
      end
    end

    context 'min is lower than max' do
      salary_range = described_class.make_salary_range('9,6-10,3 EUR na godzinę')
      it 'return populated array' do
        expect(salary_range).to eq [9.6, 10.3]
      end
    end

    context 'min is higher than max' do
      salary_range = described_class.make_salary_range('10,3-9,6 EUR na godzinę')
      it 'return sorted array' do
        expect(salary_range).to eq [9.6, 10.3]
      end
    end
  end
end
