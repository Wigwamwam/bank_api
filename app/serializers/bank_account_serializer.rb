# frozen_string_literal: true

class BankAccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :iban, :currency
end
