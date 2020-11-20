require 'rails_helper'

RSpec.describe ::Payments::GenerateToken do
  let(:przelewy24_gateway_stub) { instance_double(::Przelewy24Gateway, register_transaction: Dry::Monads::Result::Success.new('a')) }
  let(:order) { create(:order) }

  describe '#call' do
    subject(:service_call) do
      described_class.new(przelewy24_gateway_stub).call(order)
    end

    it 'generates a token' do
      expect(service_call.value!).to eq('a')
    end
  end
end
