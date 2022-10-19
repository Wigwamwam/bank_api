class BankAccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :iban, :currency
end
