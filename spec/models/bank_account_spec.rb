# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  # let(:bank_account) { build(:bank_account) }
  context 'Model Attributes' do
    describe ' Name validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(100) }
      it { is_expected.not_to allow_value(nil).for(:name) }
    end

    describe 'Iban validations ' do
      it { is_expected.to validate_presence_of(:iban) }
      it { is_expected.to validate_length_of(:iban).is_at_most(34) }
      it { is_expected.not_to allow_value(/[a-zA-Z0-9]\z/).for(:iban) }
      it { is_expected.not_to allow_value(nil).for(:iban) }
    end

    describe 'Currency validations' do
      it { is_expected.to validate_presence_of(:currency) }
      it { is_expected.to validate_inclusion_of(:currency).in_array(%w[GBP EUR USD]) }
      it { is_expected.not_to allow_value(nil).for(:currency) }
    end
  end
end
