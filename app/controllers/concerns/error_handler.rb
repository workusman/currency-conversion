# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  class CustomError < StandardError
    attr_reader :status, :code, :message

    def initialize(status = nil, code = nil, message = nil)
      super()
      @status = status || :unprocessable_entity
      @code = code || 422
      @message = message || 'Something went wrong'
    end
  end
 
  class AuthenticationError < ErrorHandler::CustomError
    def initialize
      super(:unauthorized, 401, 'Requires an API key')
    end
  end

  class Restricted < ErrorHandler::CustomError
    def initialize
      super(:forbidden, 403, 'Invalid Api Key')
    end
  end
  class AlreadyExist < ErrorHandler::CustomError
    def initialize
      super(:not_acceptable, 406, 'Already Exist')
    end
  end

  included do
    rescue_from StandardError do |e|
      respond(:internal_server_error, e)
    end

    rescue_from AuthenticationError do |e|
      respond(:unauthorized, e)
    end

    rescue_from Restricted do |e|
      respond(:forbidden, e)
    end
    
    rescue_from ActiveRecord::RecordInvalid do |e|
      Rails.logger.info e
      flat_messages = e&.record&.errors&.map { |k, v| { k => v } }&.reduce(Hash.new, :merge)
      json = error_json(:unprocessable_entity, e, errors: flat_messages || e&.message)
      render json: json, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      respond(:not_acceptable, e)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      respond(:not_found, e)
    end
  end

  private

  def respond(status, message)
    render json: error_json(status, message), status: status
  end

  def code_name_by_status(status)
    code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    name = Rack::Utils::HTTP_STATUS_CODES[code]
    [code, name]
  end

  def error_json(status, error, hash = {})
    code, name = code_name_by_status(status)
    {
      status: code,
      error: name,
      exception: {
        class: error.class.to_s,
        message: error.message
      }
    }.reverse_merge(hash)
  end
end
