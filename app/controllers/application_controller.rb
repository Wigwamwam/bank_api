# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def internal_server_error
    render json: { errors: '' }, status: :internal_server_error
  end

  def not_found(e)
    render json: { errors: e }, status: :not_found
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
end
