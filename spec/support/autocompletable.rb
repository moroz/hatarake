require 'rails_helper'

RSpec.shared_examples "acts like autocompletable" do
  def factory_key
    described_class.model_name.singular
  end

  let!(:item) { FactoryGirl.create(factory_key,
                                   name: "Foobar in English",
                                   name_pl: "Cośtam po polsku"
                                  ) }
  let!(:other) { FactoryGirl.create(factory_key,
                                    name: "Another thing",
                                    name_pl: "Jeszcze coś innego"
                                   ) }

  describe "#search" do
    context "search by English" do
      subject { described_class.search("Foobar") }
      # returns items whose English name contains given substring
      # and not others
      it { is_expected.to include item }
      it { is_expected.not_to include other }
    end

    context "search by Polish" do
      subject { described_class.search("Cośtam") }
      it { is_expected.to include item }
      it { is_expected.not_to include other }
    end

    describe "it is case-insensitive" do
      subject { described_class.search("foobar").to_a }
      it { is_expected.to eq (described_class.search("Foobar").to_a) }
    end
  end

  describe "#serialize_for_autocomplete" do
    LABEL_METHOD = "name"
    VALUE_METHOD = "name"

    def serialized_collection
      [item, other].map { |s| { id: s.id, label: s[LABEL_METHOD],
                          value: s[VALUE_METHOD] } }
    end

    subject { described_class.where(id: [item.id, other.id]).
              serialize_for_autocomplete }
    it { is_expected.to eq(serialized_collection) }
  end
end