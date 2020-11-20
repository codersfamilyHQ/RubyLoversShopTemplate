module Payments
  class GenerateToken
    include Dry::Monads[:result, :do]

    def initialize(przelewy24_gateway = ::Przelewy24Gateway.new)
      @przelewy24_gateway = przelewy24_gateway
    end

    def call(order)
      checksum = yield generate_checksum(order)
      payload = yield build_payload(checksum, order)
      token = yield register_transaction(payload)

      Success(token)
    end

    private

    attr_reader :przelewy24_gateway

    def credentials
      Rails.application.credentials
    end

    def generate_checksum(order)
      ::Payments::GenerateChecksum.new.call(order)
    end

    def build_payload(checksum, order)
      callback_url = "#{credentials[:app_url]}/orders/callback"
      payload = {
        p24_merchant_id: credentials.przelewy24[:merchant_id],
        p24_pos_id: credentials.przelewy24[:pos_id],
        p24_session_id: order.p24_session_id,
        p24_amount: order.amount_in_cents,
        p24_currency: 'PLN',
        p24_description: 'Lorem ipsum',
        p24_email: order.user_email,
        p24_country: 'PL',
        p24_url_return: credentials[:app_url],
        p24_url_status: callback_url,
        p24_api_version: '3.2',
        p24_sign: checksum
      }

      Success(payload)
    end

    def register_transaction(payload)
      przelewy24_gateway.register_transaction(payload)
    end
  end
end
