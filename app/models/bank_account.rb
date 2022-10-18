class BankAccount < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 100 }
  validates :iban,  presence: true, length: { maximum: 34, message: "Please limit to less than 34 numbers"  }
  validates :iban, format: { with: /[a-zA-Z0-9]+/,
    message: "only allows letters and numbers" }
  validates :currency,  inclusion: { in: %w(USD GBP EUR ),
    message: "%{value} is not a valid size, please either input USD, GBP, EUR" }, allow_nil: false

end
