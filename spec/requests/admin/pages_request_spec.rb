# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin', type: :request do
  let(:admin) { create(:admin_user) }

  before do
    sign_in(admin)
  end

  describe '/' do
    subject(:request) { get '/admin' }

    context 'when admin is signed in' do
      it 'renders page content' do
        request
        expect(response.body).to include('Admin section')
      end
    end
  end
end
