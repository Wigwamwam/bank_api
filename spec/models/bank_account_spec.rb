# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  # let(:bank_account) { build(:bank_account) }
  context 'Model Attributes' do
    describe ' Name validations' do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(100) }
    end

    describe 'Iban validations ' do
      it { should validate_presence_of(:iban) }
      it { should validate_length_of(:iban).is_at_most(34) }
      it { should_not allow_value(/[a-zA-Z0-9]\z/).for(:iban) }
    end

    describe 'Currency validations' do
      it { should validate_presence_of(:currency) }
      it { should validate_inclusion_of(:currency).in_array(%w[GBP EUR USD]) }
    end

    context 'Fail with blank inputs' do
      let(:bank_account) { build(:bank_account, name: nil, iban: nil, currency: nil) }
      it { expect(bank_account).not_to be_valid }
    end
  end
end
