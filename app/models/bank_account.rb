class BankAccount < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 100 }
  validates :iban,  presence: true, length: { maximum: 34 }
  validates :iban, format: { with: /[a-zA-Z0-9]\z/,
    message: "invalid characters, must only contain numbers or letters" }
  validates :currency,  inclusion: { in: %w(USD GBP EUR ),
    message: "%{value} is not a valid currency, please either input USD, GBP, EUR" }, allow_nil: false
end
