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
      render_error
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

  # def json_response(object, status = :ok)
  #   render json: object, status: status
  # end
end
