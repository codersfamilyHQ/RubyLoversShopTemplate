class Przelewy24Gateway
  def initialize(http_client = HTTP)
    @http_client = http_client
    @gateway_url = Rails.application.credentials.przelewy24[:gateway_url]
  end

  def register_transaction(payload)
    result = http_client.post("#{gateway_url}/trnRegister", form: payload)
    body = result.body.to_s
    token = CGI::parse(body)['token'].first
    Success(token)
  rescue StandardError => exception
    # report to honeybadger
    Honeybadger.report(expection)
    Failure(exception)
  end

  def verify_transaction(payload)
  end

  private

  attr_reader :http_client, :gateway_url
end
