# frozen_string_literal: true

module RequestSpecHelper
  def response_json
    if response.body.present?
      JSON.parse(response.body).with_indifferent_access
    else
      {}
    end
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
end
