require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"


  describe ".product_name_to_id" do
    context "product name equals HIGHLIGHT" do
      it "returns 4" do
        name = 'highlight'
        expect(Product.product_name_to_id(name)).to eq(4)
      end
    end

    context "product name equals CATEGORY" do
      it "returns 3" do
        name = 'category'
        expect(Product.product_name_to_id(name)).to eq(3)
      end
    end

    context "product name equals HOMEPAGE" do
      it "returns 2" do
        name = 'homepage'
        expect(Product.product_name_to_id(name)).to eq(2)
      end
    end

    context "product name different than last 3 examples" do
      it "raise BadRequest error" do
      end
    end
  end
end
