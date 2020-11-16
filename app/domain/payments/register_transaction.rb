module Payments
  class RegisterTransaction
    def call(payload)
      result = HTTP.post("https://sandbox.przelewy24.pl/trnRegister", form: payload)
      body = result.body.to_s

      # binding.pry
      puts body

      begin
        sdfsdf
      rescue StandardError => exception

      end
      Success(CGI::parse(body)['token'].first)
    end
  end
end
