# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/products', type: :request do
  let!(:product) { create(:product) }
  let!(:admin) { create(:admin_user) }
  let(:valid_attributes) do
    attributes_for(:product)
  end

  let(:invalid_attributes) do
    {
      price: 'asd'
    }
  end

  before do
    sign_in(admin)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get '/admin/products'
      expect(response.body).to include(product.title)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/admin/products/#{product.id}"

      expect(response.body).to include(product.title)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get '/admin/products/new'

      expect(response.body).to include('New Product')
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get "/admin/products/#{product.id}/edit"

      expect(response.body).to include(product.title)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      subject(:request_call) { post '/admin/products', params: { product: valid_attributes } }

      it 'creates a new Product' do
        expect { request_call }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      subject(:request_call) { post '/admin/products', params: { product: invalid_attributes } }

      it 'does not create a new Product' do
        expect { request_call }.to change(Product, :count).by(0)
      end

      it 'renders a successful response' do
        request_call
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      subject(:request_call) do
        patch "/admin/products/#{product.id}", params: { product: new_attributes }
      end

      let(:new_attributes) do
        {
          price: 100
        }
      end

      it 'updates the requested admin_product' do
        request_call
        product.reload
        expect(product.price).to eq(100)
      end

      it 'redirects to the admin_product' do
        request_call
        product.reload
        expect(response).to redirect_to(admin_product_url(product))
      end
    end

    context 'with invalid parameters' do
      subject(:request_call) do
        patch "/admin/products/#{product.id}", params: { product: invalid_attributes }
      end

      it 'renders a successful response' do
        request_call
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product' do
      expect { delete "/admin/products/#{product.id}" }.to change(Product, :count).by(-1)
    end
  end
end
