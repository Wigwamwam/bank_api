require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  let(:bank_account) { build(:bank_account) }

  it 'name should be present ' do
    bank_account.name = nil
    expect(bank_account).to_not be_valid
  end
end
