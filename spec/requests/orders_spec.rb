# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/orders', type: :request do
  let(:p24_session_id) { SecureRandom.uuid }
  let(:params) do
    {
      "p24_session_id"=> p24_session_id,
      "p24_amount"=>"5000",
      "p24_order_id"=>"305906222",
      "p24_pos_id"=>"123699",
      "p24_merchant_id"=>"123699",
      "p24_method"=>"25",
      "p24_currency"=>"PLN",
      "p24_statement"=>"p24-C90-A62-F22",
      "p24_sign"=>"45b38acacfc67a440007b2fab0a65653"
    }
  end
  let!(:order) { create(:order, p24_session_id: p24_session_id) }

  describe 'POST /callback' do
    subject(:request_call) { post '/orders/callback', params: params }

    context 'when order exists' do
      it 'updates status of the order' do
        expect { request_call }.to change { order.reload.status }.from('new').to('finished')
      end
    end
  end
end
