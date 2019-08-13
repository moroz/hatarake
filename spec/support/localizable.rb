# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'acts like localizable' do
  def factory_key
    described_class.model_name.singular
  end

  def create_item(name_en, name_pl = nil)
    FactoryBot.create(factory_key, name_en: name_en,
                                   name_pl: name_pl)
  end

  describe 'class methods' do
    before do
      DatabaseCleaner.clean_with :truncation
    end

    describe 'local_order' do
      let!(:b) { create_item 'BBBB' }
      let!(:c) { create_item 'CCCC' }
      let!(:a) { create_item 'AAAA' }

      context 'when locale is set to :en' do
        before do
          I18n.locale = :en
        end

        it 'orders by name_en' do
          expect(described_class.local_order.to_a).to eq([a, b, c])
        end
      end

      context 'when locale is set to :pl' do
        before do
          I18n.locale = :pl
        end

        let!(:b) { create_item 'CCCC', 'BBBB' }
        let!(:a) { create_item 'BBBB', 'AAAA' }
        let!(:c) { create_item 'AAAA', 'CCCC' }

        context 'when name_pl is present' do
          it 'orders by name_pl' do
            expect(described_class.local_order.to_a).to eq([a, b, c])
          end
        end

        context 'when no name_pl present' do
          let!(:b) { create_item 'CCCC', nil }
          let!(:a) { create_item 'BBBB', nil }
          let!(:c) { create_item 'AAAA', nil }

          it 'orders by name_en' do
            expect(described_class.local_order.to_a).to eq([c, a, b])
          end
        end
      end
    end
  end
end
