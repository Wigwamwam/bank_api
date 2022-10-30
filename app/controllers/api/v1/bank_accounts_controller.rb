# frozen_string_literal: true

module Api
  module V1
    class BankAccountsController < ApplicationController
      before_action :get_bank_account, only: [:destroy]

      def index
        @bank_accounts = BankAccount.all
        render json: @bank_accounts
      end

      def create
        @bank_account = BankAccount.create(bank_account_params)
        if @bank_account.save
          render json: @bank_account, status: :created
        else
          render_bad_request
        end
      end

      def destroy
        # exclamation mark to ensure that error rises when it fails
        @bank_account.destroy!
        head :no_content
      end

      private

      def bank_account_params
        params.permit(:name, :iban, :currency)
      end

      def get_bank_account
        @bank_account = BankAccount.find(params[:id])
      end
    end
  end
end
