module Secured
  extend ActiveSupport::Concern
  included do
    prepend_before_action :authenticate_request!
    helper_method :current_project
  end

  private

  def authenticate_request!
    token = request.headers[:HTTP_API_TOKEN]
    raise ErrorHandler::AuthenticationError unless token.present?
    @api_key = ApiKey.find_by(token: token)
    raise ErrorHandler::Restricted unless @api_key.present?

  end

  def current_project
    @current_project = @api_key.project
  end
end
