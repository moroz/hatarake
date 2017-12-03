require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:offer) { FactoryBot.build(:offer) }
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        expect(offer).to be_valid
      end
    end

    describe "currency" do
      context "without currency" do
        it "is invalid" do
          offer.currency = nil
          expect(offer).not_to be_valid
        end
      end

      # Currency should be an ISO 4217-compliant
      # three-letter code
      context "with invalid currency" do
        it "is invalid" do
          offer.currency = "zł"
          expect(offer).not_to be_valid
        end
      end
    end

    context "without title" do
      it "is invalid" do
        offer.title = nil
        expect(offer).not_to be_valid
      end
    end

    context "without company" do
      it "is invalid" do
        offer.company = nil
        expect(offer).not_to be_valid
      end
    end

    context "when apply_on_website is false" do
      let(:offer) { FactoryBot.build(:offer, apply_on_website: false) }
      context 'without application_url' do
        it 'is valid' do
          offer.application_url = nil
          expect(offer).to be_valid
        end
      end
    end

    context "when apply_on_website is true" do
      let(:offer) { FactoryBot.build(:offer, :apply_on_website) }

      context "without application_url" do
        it "is invalid" do
          offer.application_url = nil
          expect(offer).not_to be_valid
        end
      end

      context "with invalid application_url" do
        it "is invalid" do
          offer.application_url = 'foobar'
          expect(offer).not_to be_valid
        end
      end

      context "with valid application_url" do
        it "is valid" do
          offer.application_url = 'https://www.injobs.pl'
          expect(offer).to be_valid
        end
      end
    end
  end

  describe 'make_required_languages' do
    let(:offer) { FactoryBot.build(:offer) }

    before(:each) do
      offer.req_lang_2 = 5
    end

    after(:each) do
      offer.validate
      expect(offer.req_lang_2).to be nil
    end

    context 'when req_lang_2 == req_lang_1' do
      it 'sets req_lang_2 to nil' do
        offer.req_lang_1 = 5
      end
    end

    context 'when req_lang_1 is nil' do
      it 'sets req_lang_2 to nil' do
        offer.req_lang_1 = nil
      end
    end

    context 'when req_lang_1 == 1' do
      it 'sets req_lang_2 to nil' do
        offer.req_lang_1 = 1
      end
    end

    context 'when req_lang_2 == 1' do
      it 'sets req_lang_2 to nil' do
        offer.req_lang_2 = 1
      end
    end
  end

  describe 'make_hourly_wage' do
    let(:offer) { FactoryBot.build(:offer) }

    context 'upon save' do
      context "when given numbers with point as decimal separator" do
        before(:each) do
          offer.hourly_wage_min = '10.5'
          offer.hourly_wage_max = '13.0'
          offer.save
        end

        describe "makes a correct range" do
          it 'lower bound is correct' do
            expect(offer.hourly_wage.first).to eq(10.5)
          end

          it 'upper bound is correct' do
            expect(offer.hourly_wage.last).to eq(13)
          end
        end
      end

      context 'when given numbers with comma as decimal separator' do
        before(:each) do
          offer.hourly_wage_min = '17,5'
          offer.hourly_wage_max = '19,5'
          offer.save
        end

        describe "makes a correct range" do
          it 'lower bound is correct' do
            expect(offer.hourly_wage.first).to eq(17.5)
          end

          it 'upper bound is correct' do
            expect(offer.hourly_wage.last).to eq(19.5)
          end
        end
      end

      context 'when min > max' do
        context 'upon save' do
          describe 'swaps min and max' do
            before(:each) do
              offer.hourly_wage_min = '25.5'
              offer.hourly_wage_max = '15.5'
              offer.save
            end

            it 'lower bound is correct' do
              expect(offer.hourly_wage.first).to eq(15.5)
            end

            it 'upper bound is correct' do
              expect(offer.hourly_wage.last).to eq(25.5)
            end
          end
        end
      end
    end
  end

  describe "publishing" do
    context "when created" do
      let(:offer) { FactoryBot.create(:offer) }

      it 'published is true' do
        expect(offer.reload).to be_published
      end
    end

    describe "#publish" do
      before do
        offer.publish
      end

      it "published is true" do
        expect(offer).to be_published
      end

      it "published_at is set" do
        expect(offer.published_at).not_to be_nil
      end
    end
  end

  describe "scopes" do
    describe "featured"

    describe "with_country_id" do

    end

    describe "with_province_id" do

    end

    describe "offers in Poland and abroad" do
      let!(:offer_pl) { FactoryBot.create(:offer, :published, :poland) }
      let!(:offer_de) { FactoryBot.create(:offer, :published, :germany) }

      describe "poland" do
        subject { Offer.poland.to_a }

        it { is_expected.to include offer_pl }
        it { is_expected.not_to include offer_de }
      end

      describe "abroad" do
        subject { Offer.abroad.to_a }

        it { is_expected.to include offer_de }
        it { is_expected.not_to include offer_pl }
      end

    end

    describe "featured scopes" do
      let!(:unfeatured) { FactoryBot.create(:offer, :unfeatured) }
      let!(:homepage_featured) { FactoryBot.create(:offer, :homepage_featured) }

      describe "#homepage_featured" do
        let!(:homepage_past) { FactoryBot.create(:offer, featured_until: 2.weeks.ago) }

        subject { Offer.homepage_featured }
        it { is_expected.to include(homepage_featured) }
        it { is_expected.not_to include(unfeatured) }
        it { is_expected.not_to include(homepage_past) }
      end

      describe "offers featured within category" do
        let!(:category_featured) { FactoryBot.create(:offer, :category_featured) }
        let!(:category_past) { FactoryBot.create(:offer, category_until: 2.weeks.ago) }

        describe "#category_featured" do
          subject { Offer.category_featured }
          it { is_expected.to include(category_featured) }
          it { is_expected.not_to include(unfeatured) }
          it { is_expected.not_to include(category_past) }
        end

        describe "#not_category_featured" do
          subject { Offer.not_category_featured }
          it { is_expected.not_to include(category_featured) }
          it { is_expected.to include(unfeatured) }
          it { is_expected.to include(category_past) }
        end
      end
    end

    describe "adding premium services" do
      let(:offer) { FactoryBot.create(:offer, :published) }

      describe "self.add_premium" do
        let!(:offers) { FactoryBot.create_list(:offer, 3) }

      end
    end
  end
end
