module Payments
  class GenerateChecksum
    include Dry::Monads[:result]

    def call(order)
      checksum_string = [
        order.p24_session_id,
        credentials.przelewy24[:merchant_id],
        order.amount_in_cents,
        order.currency,
        credentials.przelewy24[:crc_key],
      ].join('|')

      checksum = Digest::MD5.hexdigest(checksum_string)

      Success(checksum)
    end

    private

    def credentials
      Rails.application.credentials
    end
  end
end
