# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::BankAccounts', type: :request do
  let(:bank_account) { create(:bank_account) }

  describe 'GET / index' do
    let(:get_bank_accounts) { get '/v1/bank_accounts' }

    context 'with 0 bank_accounts' do
      before { get_bank_accounts }

      it 'returns 0 bank account' do
        expect(parsed_response).to be_empty
        expect(parsed_response.size).to eq(0)
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'with 1 bank_accounts' do
      let!(:bank_account) { create(:bank_account) }

      before { get_bank_accounts }

      it 'returns 1 bank account' do
        expect(parsed_response).not_to be_empty
        expect(parsed_response.size).to eq(1)
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'with 3 bank_accounts' do
      let!(:bank_accounts) { create_list(:bank_account, 3) }

      before { get_bank_accounts }

      it 'returns 3 bank accounts' do
        expect(parsed_response).not_to be_empty
        expect(parsed_response.size).to eq(3)
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'with invalid all method' do
      it 'returns internal_server_error: returns status code 500' do
        allow(BankAccount).to receive(:all).and_raise('some error')
        get '/v1/bank_accounts'
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'POST / create' do
    let(:valid_attributes) { { name: 'Test Bank Account', iban: 'RO66BACX0000001234567890', currency: 'USD' } }

    context 'with valid request' do
      before { post '/v1/bank_accounts', params: valid_attributes }

      it 'creates a bank account' do
        expect(parsed_response['name']).to eq('Test Bank Account')
        expect(parsed_response['iban']).to eq('RO66BACX0000001234567890')
        expect(parsed_response['currency']).to eq('USD')
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'when request is invalid' do
      before do
        post '/v1/bank_accounts',
             params: { name: 'Test Bank Account', iban: 'RO66BACX00000012345678', currency: 'cccc' }
      end

      it 'bad_request: returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'bad_request: returns json format error message' do
        expect(parsed_response).to eq(
          {
            'errors' => [{ 'field' => 'currency', 'error' => 'is not included in the list' }]
          }
        )
      end

      context 'with invalid create method' do
        it 'returns internal_server_error: returns status code 500' do
          allow(BankAccount).to receive(:create).and_raise('some error')
          post '/v1/bank_accounts', params: valid_attributes
          expect(response).to have_http_status(:internal_server_error)
        end
      end

      context 'with invalid save method' do
        it 'returns internal_server_error: returns status code 500' do
          allow_any_instance_of(BankAccount).to receive(:save).and_raise('some error')
          post '/v1/bank_accounts', params: valid_attributes
          expect(response).to have_http_status(:internal_server_error)
        end
      end
    end
  end

  # Destroy

  describe 'DELETE /destroy' do
    context 'when request is valid' do
      before { delete "/v1/bank_accounts/#{bank_account.id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when request is invalid' do
      it 'not_found: returns status code 404' do
        delete '/v1/bank_accounts/300'
        expect(response).to have_http_status(:not_found)
      end

      it 'internal_server_error: returns status code 500' do
        allow(BankAccount).to receive(:find).and_raise('some error')
        delete "/v1/bank_accounts/#{bank_account.id}"
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
