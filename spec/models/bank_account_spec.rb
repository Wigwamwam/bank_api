require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  let(:bank_account) { build(:bank_account) }

  it 'name should be present ' do
    bank_account.name = nil
    expect(bank_account).to_not be_valid
  end

  it 'name should not exceed 100 characters' do
    bank_account.name = 'a' * 101
    expect(bank_account).to_not be_valid
  end

  # it 'name should not consist of 3 or less characters' do
  #   bank_account.name = 'a' * 3
  #   expect(bank_account).to_not be_valid
  # end

  it 'iban should be present ' do
    bank_account.iban = nil
    expect(bank_account).to_not be_valid
  end

  it 'iban should not exceed 34 characters ' do
    bank_account.iban = 'a' * 34
    expect(bank_account).to_not be_valid
  end

  it 'iban should only include letters and numbers' do
    bank_account.iban = "!@£$%^&*()<>?:"
    expect(bank_account).to_not be_valid
  end

  it 'currency should be present ' do
    bank_account.currency = nil
    expect(bank_account).to_not be_valid
  end

  it 'currency should consists of GBP, EUR and USD ' do
    bank_account.currency = "Dollars"
    expect(bank_account).to_not be_valid
  end
end
