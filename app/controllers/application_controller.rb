# frozen_string_literal: true

class ApplicationController < ActionController::API
rescue ActiveRecord::RecordNotFound => e
  render json: { errors: e }, status: :not_found
end
