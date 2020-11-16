require 'rails_helper'

RSpec.describe ::Payments::GenerateChecksum do
  describe '#call' do
    subject { described_class.new.call(order).value! }

    let(:order) { build(:order, amount: 50, p24_session_id: 'abcdefghijk') }
    let(:expected_result) { '6e27ef9bf5230bf556314bc8cdba145f' }

    it { is_expected.to eq(expected_result) }
  end
end
