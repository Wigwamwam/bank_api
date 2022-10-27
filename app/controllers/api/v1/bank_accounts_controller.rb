# frozen_string_literal: true
#
module Api
  module V1
    class BankAccountsController < ApplicationController
      before_action :get_bank_account, only: [:destroy]

      rescue_from StandardError, :with => :internal_server_error

      def index
        @bank_accounts = BankAccount.all
        raise StandardError.new
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
        @bank_account.destroy
        head :no_content
      end

      private

      def bank_account_params
        params.permit(:name, :iban, :currency)
      end

      def render_bad_request
        render json: { errors: error_message(@bank_account.errors.as_json) },
               status: :bad_request
      end

      def error_message(errors)
        errors.map do |key, value|
          { 'field' => key.to_s, 'error' => value.first }
        end
      end

      def get_bank_account
        @bank_account = BankAccount.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e }, status: :not_found
      end

      def internal_server_error
        render json: { errors: "" }, status: :internal_server_error
      end

    end
  end
end
