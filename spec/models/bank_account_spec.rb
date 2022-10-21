require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  let(:bank_account) { build(:bank_account) }

  describe "--- Name -- " do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
  end

  describe "--- Iban -- " do
    it { should validate_presence_of(:iban) }
    it { should validate_length_of(:iban).is_at_most(34) }
    it { should_not allow_value(/[a-zA-Z0-9]\z/).for(:iban) }
  end

  describe "---Currency --" do
    it { should validate_presence_of(:currency) }
    it { should validate_inclusion_of(:currency).in_array(['GBP', 'EUR', 'USD']) }
  end
end
