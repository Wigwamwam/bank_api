# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.string :name
      t.string :iban
      t.string :currency

      t.timestamps
    end
  end
end
