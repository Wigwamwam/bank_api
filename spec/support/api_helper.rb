# frozen_string_literal: true

module ApiHelper
  def parsed_response
    JSON.parse(response.body)
  end
end
