FactoryBot.define do
  factory :bank_account do
    name { 'Test Account' }
    iban { 'RO66BACX0000001234567890' }
    currency { 'USD' }
  end
end
