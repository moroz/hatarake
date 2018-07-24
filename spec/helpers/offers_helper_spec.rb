require 'rails_helper'

RSpec.describe OffersHelper do
  describe "#pretty_currency_value" do
    context "when value is nil"
    context "when value is infinity"
    context "when value is a real number"
  end

  describe "#localized_currency_value" do
    context "when value is nil"
    context "with locale == :pl" do
      it "uses comma as decimal separator"
    end
    context "with locale == :en" do
      it "uses point as decimal separator"
    end
  end

  #moved to currency helper
  describe "#readable_currency_range" do
    def salary_string(format, min, max, currency)
      I18n.t('currency_range.' + format, min: min, max: max, currency: currency.upcase)
    end

    context "when min and max present" do

      context "when min == max" do
        it "returns one value" do
          # 1000 PLN
          expect(helper.readable_currency_range((1000..1000), "pln")).to eq(salary_string('mineqmax', 1000, 1000, 'pln'))
        end
      end

      context "when min != max" do
        it "returns a range" do
          # 1000-2000 PLN
          expect(helper.readable_currency_range((1000..2000), "pln")).to eq(salary_string('minmax', 1000, 2000, 'pln'))
        end
      end
    end

    context "when only min present" do
      it "returns min+" do
        # 1000+ PLN
        expect(helper.readable_currency_range((1000..Float::INFINITY), "pln")).to eq(salary_string('min', 1000, nil, 'pln'))
      end
    end

    context "when only max present" do
      it "returns up to max" do
        # up to 2000 PLN
        expect(helper.readable_currency_range((-Float::INFINITY..2000), "pln")).to eq(salary_string('max', nil, 2000, 'pln'))
      end
    end

    context "with -Infinity...Infinity" do
      it "returns a placeholder string" do
        # none given
        expect(helper.readable_currency_range((-Float::INFINITY..Float::INFINITY), "pln")).to eq(salary_string('none', nil, nil, 'pln'))
      end
    end

    context "with nil" do
      it "returns placeholder string" do
        # none given
        expect(helper.readable_currency_range(nil, "pln")).to eq(salary_string('none', nil, nil, 'pln'))
      end
    end
  end

  describe '#prepare_offer_meta_description' do
    let(:offer) { FactoryBot.build(:offer, :published, :one_location) }
    let(:company) { FactoryBot.build(:company) }

    subject { helper.prepare_offer_meta_description(offer, company) }
    it { is_expected.to include(company.name) } # I'm not sure if I understood your intent properly
    it { is_expected.to include(offer.locations.first.only_city_format) }
  end
end
