class Api::V1::BankAccountsController < ApplicationController

  def index
    @bank_accounts = BankAccount.all
    render json: @bank_accounts
  end

  def create
    @bank_account = BankAccount.create(bank_account_params)
    if @bank_account.save
      render json: @bank_account, status: :created
    else
      render json: { :errors => error_message(@bank_account.errors.as_json) }, status: :bad_request
    end
  end

  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy
    head :no_content
  end

  private

  def bank_account_params
    params.permit(:name, :iban, :currency)
  end

  # need to place this inside the lib, however this is not flexible for different errros, I need to create a error folder, where depending on the error it displaces different responses
  def error_message(errors)
    errors.map do |key, value|
      { "field" => key.to_s, "error" => value.first }
    end
  end
  
end
