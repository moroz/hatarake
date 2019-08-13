# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferImporter do

  describe 'self.root_url' do
    it 'raise NotImplementeError' do
      expect(described_class.import).to raise_error
    end
  end

  describe 'self.import' do
    context 'root_url is defined' do
      it 'return an Array' do
        allow(described_class).to receive(:root_url).and_return('https://silverhand.eu/jooble.php')
        expect(described_class.import).to be_a(Hash)
      end
    end

    # context 'root_url isn\'t defined' do
    #   it 'raise NotImplementeError' do
    #     expect(described_class.import).to raise_error
    #   end
    # end
  end

end
