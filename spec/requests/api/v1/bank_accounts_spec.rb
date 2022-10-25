require 'rails_helper'

def json
  JSON.parse(response.body)
end


RSpec.describe 'Api::V1::BankAccounts', type: :request do
  describe 'GET / index' do
    let!(:bank_accounts) { create_list(:bank_account, 5) }

    before { get '/api/v1/bank_accounts' }

    it 'returns bank accounts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST / create' do
    let (:valid_attributes)  { { name: 'Test Bank Account', iban:  'RO66BACX0000001234567890', currency: 'USD' } }

    context 'when request is valid' do
      before { post '/api/v1/bank_accounts', params: valid_attributes}

      it 'creates a bank account' do
        expect(json["name"]).to eq('Test Bank Account')
        expect(json['iban']).to eq('RO66BACX0000001234567890')
        expect(json['currency']).to eq('USD')
      end

      it { expect(response).to have_http_status(201) }
    end

    context 'when request is invalid' do
        before { post '/api/v1/bank_accounts', params: { :name => 'Test Bank Account', :iban => 'RO66BACX00000012345678', :currency => 'cccc' } }

        it 'returns status code 400' do
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns json format error message' do
          expect(json).to eq(
            {
              "errors"=>[{"error"=>"is not included in the list", "field"=>"currency"}]
            }
            )
        end
      # need to create the 500 message, coz currently what type of request would call a 500
    end


  end

  describe "DELETE /destroy" do
    let!(:bank_account) { create(:bank_account) }

    before { delete "/api/v1/bank_accounts/#{bank_account.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    describe "Error message - 404 - could not find ID" do
      before { delete '/api/v1/bank_accounts/300' }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
