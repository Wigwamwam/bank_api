# frozen_string_literal: true

module ApiHelper
  def json
    JSON.parse(response.body)
  end
end
