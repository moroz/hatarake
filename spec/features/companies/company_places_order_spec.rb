require 'rails_helper'

RSpec.describe 'Company places Order' do
  fixtures :products
  let(:company) { FactoryBot.create(:company) }
  before do
    login_as(company, scope: :company)
  end

  describe 'displaying products in products#index' do
    it 'displays all products' do
      visit premium_path
      expect(page).to have_selector('.product', count: Product.count)
    end
  end

  describe 'adding items to cart' do
    it 'adds new items to cart' do
      visit premium_path

      within '#product_1' do
        find('input[type="number"]').set(2)
        submit_form
      end
      visit cart_path
      expect(page).to have_selector('.cart_item', count: 1)
      within('.cart_item') do
        expect(page).to have_content('2')
      end
    end
  end

  describe 'checking out' do
    let(:cart) { FactoryBot.create(:cart, user: company) }
    before do
      cart.add_item(1, 2)
    end

    it 'creates Order with associated BillingAddress' do
      visit cart_path
      click_link_or_button I18n.t('carts.cart.place')
      expect(current_path).to eq(place_order_path)
      find('#order_invoice').set(true)
      find('#order_billing_address_attributes_first_name').set('Miś')
      find('#order_billing_address_attributes_last_name').set('Uszatek')
      find('#order_billing_address_attributes_street').set('ul. Stepana Bandery')
      find('#order_billing_address_attributes_house_no').set('69')
      find('#order_billing_address_attributes_postal_code').set('75-100')
      find('#order_billing_address_attributes_city').set('Ostrowiec Świętokrzyski')
      find('#order_billing_address_attributes_nip').set('100500100900')
      expect { submit_form }.to change { Order.count }
      o = Order.last
      expect(o.billing_address).to be_persisted
    end
  end
end
