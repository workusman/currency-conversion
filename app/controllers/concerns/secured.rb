module Secured
  extend ActiveSupport::Concern
  included do
    prepend_before_action :authenticate_request!
  end

  private

  def authenticate_request!
    token = request.headers[:HTTP_API_TOKEN]
    raise ErrorHandler::AuthenticationError unless token.present?
    raise ErrorHandler::Restricted unless ApiKey.exists?(token: token)
  end


end
