require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryGirl.create(:cart) }
  let(:product) { FactoryGirl.create(:product) }

  describe "when created" do
    it "has no items" do
      expect(cart).to be_empty
    end

    it "is not finalized" do
      expect(cart).not_to be_finalized
    end

    it "is modifiable" do
      expect(cart).not_to be_readonly
    end
  end

  describe "#to_h" do
    let(:product2) { FactoryGirl.create(:product) }

    it "returns a hash of product_ids => quantities" do
      cart.add_item(product, 3)
      cart.add_item(product2, 2)
      
      expect(cart.to_h).to eq({product.id => 3, product2.id => 2})
    end
  end

  describe "#add_item" do
    context 'when given item is not present' do
      before do
        cart.add_item(product, quantity = 2)
      end

      it "changes cart items count" do
        expect(cart.cart_items.count).to eq(1)
      end

      it "cart item's quantity equals given quantity" do
        expect(cart.cart_items.first.quantity).to eq(2)
      end
    end

    context "when given item is already in the cart" do
      before do
        cart.cart_items.create(product: product, quantity: 2)
      end

      it "changes item quantity" do
        expect { cart.add_item(product, 3) }.to change { cart.cart_items.first.quantity }
      end

      it "does not change cart item count" do
        expect { cart.add_item(product, 3) }.not_to change { cart.cart_items.count }
      end
    end
  end

  describe "#finalize" do
    # this method should set finalized = true, and create an Order
    # thereby preventing further modification of the record
    context "when called on an unfinalized cart" do
      before do
        cart.finalize!
      end

      it "changes finalized to true" do
        expect(cart).to be_finalized
      end

      it "sets finalized_at to NOW()" do
        expect(cart.finalized_at).to be_within(1.second).of(Time.now)
      end

      it "makes record read-only" do
        expect(cart).to be_readonly
      end
    end

  end

  describe "#total" do
    context "when there are no items in the cart" do
      it "returns 0.00" do
        expect(cart.total).to eq(0)
      end
    end

    context 'when items are present in the cart' do
      let(:prod1) { FactoryGirl.create(:product, price_pln: 10, price_eur: 3) }
      let(:prod2) { FactoryGirl.create(:product, price_pln: 20, price_eur: 5) }
      
      before do
        cart.add_item(prod1, 3)
        cart.add_item(prod2, 2)
      end

      it 'equals sum of subtotals (unit price * quantity)' do
        expect(cart.total).to eq(70)
      end

      describe 'price in euro' do
        it 'equals sum of subtotals in euro' do
          expect(cart.total(:eur)).to eq(19)
        end
      end
    end

  end
end
