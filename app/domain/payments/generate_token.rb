module Payments
  class GenerateToken
    include Dry::Monads[:result, :do]

    def initialize(register_transaction_service = ::Payments::RegisterTransaction.new)
      @register_transaction_service = register_transaction_service
    end

    def call(order)
      checksum = yield generate_checksum(order)
      payload = yield build_payload(checksum, order)
      token = yield register_transaction(payload)

      Success(token)
    end

    private

    attr_reader :register_transaction_service

    def credentials
      Rails.application.credentials
    end

    def generate_checksum(order)
      ::Payments::GenerateChecksum.new.call(order)
    end

    def build_payload(checksum, order)
      callback_url = 'http://b9e6e8fb8af8.ngrok.io/orders/callback'
      payload = {
        p24_merchant_id: credentials.przelewy24[:merchant_id],
        p24_pos_id: credentials.przelewy24[:pos_id],
        p24_session_id: order.p24_session_id,
        p24_amount: order.amount_in_cents,
        p24_currency: 'PLN',
        p24_description: 'Lorem ipsum',
        p24_email: order.user_email,
        p24_country: 'PL',
        p24_url_return: 'http://b9e6e8fb8af8.ngrok.io',
        p24_url_status: callback_url,
        p24_api_version: '3.2',
        p24_sign: checksum
      }

      Success(payload)
    end

    def register_transaction(payload)
      register_transaction_service.call(payload)
    end
  end
end
