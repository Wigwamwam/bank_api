# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BankAccountSerializer, type: :serializer do

  let(:bank_account) { create(:bank_account) }

  let(:json) { described_class.new(bank_account).as_json }

  it { expect(json).to include(:name, :iban, :currency)}

  it "has types" do
    expect(json[:name]).to be_kind_of(String)
    expect(json[:iban]).to be_kind_of(String)
    expect(json[:currency]).to be_kind_of(String)
  end

  it "has values" do
    expect(json[:name]).to eq(bank_account.name)
    expect(json[:iban]).to eq(bank_account.iban)
    expect(json[:currency]).to eq(bank_account.currency)
  end


    # it 'returns correct keys and values' do
    #   expect(subject).to include (
    #     name: be_a(String);
    #     iban: be_a(String);
    #     currency: be_a(String)
    #   )
    # end
end
