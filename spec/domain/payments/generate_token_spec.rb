require 'rails_helper'

RSpec.describe ::Payments::GenerateToken do
  let(:register_transaction_stub) { instance_double(::Payments::RegisterTransaction, call: Dry::Monads::Result::Success.new('a')) }
  let(:order) { create(:order) }

  describe '#call' do
    subject(:service_call) do
      described_class.new(register_transaction_stub).call(order)
    end

    it 'generates a token' do
      # binding.pry
      expect(service_call.value!).to eq('a')
    end
  end
end
