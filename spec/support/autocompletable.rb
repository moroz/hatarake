require 'rails_helper'

RSpec.shared_examples "acts like autocompletable" do
  def factory_key
    described_class.model_name.singular
  end

  let(:item) { FactoryGirl.create(factory_key,
                                 name: "Foobar in English",
                                 name_pl: "Cośtam po polsku"
                                 ) }
  let(:other) { FactoryGirl.create(factory_key,
                                   name: "Another thing",
                                   name_pl: "Jeszcze coś innego"
                                  ) }

  describe "#search" do
    context "when called with English name" do
      subject { described_class.search("Foobar") }
      # returns items which contain English name
      # and not others
      it { is_expected.to include item }
      it { is_expected.not_to include other }
    end
  end
end
