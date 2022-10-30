# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccountSerializer, type: :serializer do
  let(:bank_account) { create(:bank_account) }

  let(:json) { described_class.new(bank_account).as_json }

  it { expect(json).to include(:name, :iban, :currency) }

  it 'has associated values' do
    expect(json[:name]).to eq(bank_account.name)
    expect(json[:iban]).to eq(bank_account.iban)
    expect(json[:currency]).to eq(bank_account.currency)
  end
end
