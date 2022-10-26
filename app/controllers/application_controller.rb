# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue ActiveRecord::RecordNotFound => error
    render  json: { errors: error }, status: :not_found
  rescue => error
    render json: { errors: error }, status: :internal_server_error

  
end
