class BankAccount < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 100 }
  validates :iban,  presence: true, length: { maximum: 34, message: "invalid length, must be 34 characters or less"  }
  validates :iban, format: { with: /[a-zA-Z0-9]+/,
    message: "invalid characters, must only contain numbers or letters" }
  validates :currency,  inclusion: { in: %w(USD GBP EUR ),
    message: "%{value} is not a valid size, please either input USD, GBP, EUR" }, allow_nil: false
end
