# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :bank_account do
    name { "Test: #{Faker::Name.name}" }
    iban { Faker::Bank.iban }
    currency { %w[USD GBP EUR].sample }
  end
end
