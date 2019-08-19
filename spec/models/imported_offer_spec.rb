# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportedOffer, type: :model do
  describe 'scopes' do
    describe 'published and unpublished imported offers' do
      let!(:offer_unpublished) { FactoryBot.create(:imported_offer) }
      let!(:offer_published) { FactoryBot.create(:imported_offer, published: true) }

      describe 'unpublished' do
        subject { described_class.unpublished }

        it { is_expected.to include offer_unpublished }
      end

      describe 'published' do
        subject { described_class.published }

        it { is_expected.to include offer_published }
      end

      describe 'social_featured'
    end
  end

  describe '#publish' do
    let(:offer) { FactoryBot.create(:imported_offer) }
    subject { offer.publish }

    it 'publish offer' do
      subject
      expect(offer.published).to eq true
    end
  end

  describe '#self.save_offers' do
    context 'offers array passed as argument' do
      context 'offer with the same external id exists' do
        let(:offers) { [FactoryBot.attributes_for(:imported_offer, external_id: '1')] }
        it 'isn\'t saving existing offers' do
          FactoryBot.create(:imported_offer, external_id: '1')
          expect { described_class.save_offers(offers) }.not_to change { ImportedOffer.count }
        end
      end

      context 'offer with the same external id doesn\'t exists' do
        let(:offers) { [FactoryBot.attributes_for(:imported_offer)] }
        it 'is saving new offers' do
          expect { described_class.save_offers(offers) }.to change { ImportedOffer.count }.by(1)
        end
      end
    end

    context 'offers array not passed as argument' do
      it 'is saving imported from Silverhand offers' do
        expect { described_class.save_offers }.to change { ImportedOffer.count }
      end
    end
  end

  describe '#self.prepare_to_publish' do
    before { FactoryBot.create(:field) }
    let(:offer) { [FactoryBot.create(:imported_offer)] }
    let(:ready_to_publish_offers) { described_class.prepare_to_publish(offer) }

    it 'delete present in Imported Offers but unpresent in Offers fields' do
      expect(ready_to_publish_offers.first).not_to include(*%i[id location external_url source published field_name])
    end

    it 'return array of hashes' do
      expect(ready_to_publish_offers).to be_a(Array)
      expect(ready_to_publish_offers.first).to be_a(Hash)
    end
  end

  # TODO: Test private methods
end
