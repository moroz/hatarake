# frozen_string_literal: true

require 'rails_helper'

def post_params
  {
    'id' => '791904', 'operation_number' => 'M9283-8213', 'operation_type' => 'payment',
    'operation_status' => 'completed', 'operation_amount' => '104.36',
    'operation_currency' => 'PLN', 'operation_original_amount' => '24.60',
    'operation_original_currency' => 'EUR', 'operation_datetime' => '2017-08-04 17:48:29',
    'control' => '280533fa22fb47a95cac', 'description' => 'InJobs.pl usługi premium',
    'email' => 'mis@uszatek.pl', 'p_info' => 'Test User (k.j.moroz@gmail.com)',
    'p_email' => 'k.j.moroz@gmail.com', 'channel' => '246',
    'signature' => '3b238784d1277d83a4731c9c6b00f8e0721124ee2f487f115bc90f1202ea8962'
  }
end

RSpec.describe 'Dotpay confirmation', type: :request do
  let!(:order) { FactoryBot.create(:order, unique_token: '280533fa22fb47a95cac') }

  before do
    post '/api/dotpay/confirm_payment', params: post_params
    order.reload
  end

  it 'sets order status and renders OK' do
    expect(order.payment_status).to eq('completed')
  end

  it "sets user's premium_services" do
    expect(order.user.premium_services).to eq(order.to_h)
  end

  it 'returns OK' do
    expect(response.body).to eq('OK')
  end

  it 'response type is text/plain' do
    expect(response.content_type).to eq('text/plain')
  end
end
