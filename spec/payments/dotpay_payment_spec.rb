# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DotpayPayment do
  before do
    # sample POST data from Dotpay
    beginning = 'id=791904&operation_number=M9750-8300&operation_type=payment&operation_status=completed&
                operation_amount=36.00&operation_currency=PLN&operation_original_amount=36.00&
                operation_original_currency=PLN&operation_datetime=2017-07-19+11%3A02%3A39&
                control=&description=Sianko&email=k.j.moroz%40gmail.com&
                p_info=Test+User+%28k.j.moroz%40gmail.com%29&p_email=k.j.moroz%40gmail.com&channel=246&signature='
    @correct = beginning + '3bdb2083d483543c56375b5f5c72c056f4c7a8a45ddcd7cddb7b1db8aa369146'
    @wrong = beginning + 'a66b977b364f435816d2ca05efb8dc39adfa29042578a5f57eec3b279cd616fa'
  end

  describe '#acknowledge' do
    context 'with correct signature' do
      it 'returns true' do
        @payment = described_class.new(@correct)
        expect(@payment.acknowledge).to be true
      end
    end

    context 'with wrong signature' do
      it 'returns false' do
        @payment = described_class.new(@wrong)
        expect(@payment.acknowledge).to be false
      end
    end
  end
end
