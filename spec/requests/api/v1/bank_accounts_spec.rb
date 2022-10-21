require 'rails_helper'

def json
  JSON.parse(response.body)
end


RSpec.describe 'Api::V1::BankAccounts', type: :request do
  describe 'GET / index' do
    let!(:bank_accounts) { create_list(:bank_account, 5) }

    before { get '/api/v1/bank_accounts' }

    it 'returns all bank accounts' do
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response.status).to eq(200)
    end
  end

  describe 'POST / create' do
    before do
      post '/api/v1/bank_accounts', params: { :name => 'Test Bank Account', :iban => 'RO66BACX0000001234567890', :currency => 'USD' }
    end

    it 'returns the bank account - name' do
      expect(json['name']).to eq('Test Bank Account')
    end

    it 'returns the bank account - iban' do
      expect(json['iban']).to eq('RO66BACX0000001234567890')
    end

    it 'returns the bank account - currency' do
      expect(json['currency']).to eq('USD')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

    describe 'Error message - Invalid request' do
      before do
        post '/api/v1/bank_accounts', params: { :name => 'Test Bank Account', :iban => 'RO66BACX00000012345678', :currency => 'cccc' }
      end

      it 'returns status code 400 - invalid request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns json format error message' do
        expect(json).to eq(
          {
            "errors"=>[{"error"=>"cccc is not a valid currency, please either input USD, GBP, EUR", "field"=>"currency"}]
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

    # describe "Error message - 404 - could not find ID" do
    #   before { delete '/api/v1/bank_accounts/300' }

    #   it 'returns status code 404' do
    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
  end
end
    # context 'when resource is found' do
    #   it 'responds with 200'
    #   it 'shows the resource'
    # end

    # context 'when resource is not found' do
    #   it 'responds with 404'
    # end

    # context 'when resource is not owned' do
    #   it 'responds with 404'
    # end
