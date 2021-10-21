class Api::V1::CurrencyRatesController < Api::V1::BaseController

  before_action :validate_conversion_params, only: [:conversion]

  def index
    @currency_rates = current_project.currency_rates
  end

  def conversion
    response = CurrencyConverter.new(current_project, params).convert
    render json: response
  end

  private

  #we can move this code to custom validator
  def validate_conversion_params
    errors = []
    [:from, :to, :amount].each do |key, value|
      if !params.include?(key) || params[key].blank?
        message = "#{key.to_s.humanize} is required"
        errors.push(message)
      end
    end

    [:from, :to].each do |key, value|
      if params.include?(key) && params[key].present? && !CurrencyRate::SUPPORTED_CURRENCIES.include?(params[key])
        message = "#{key.to_s.humanize} Currency is not Supported yet"
        errors.push(message)
      end
    end

    if params[:from] && params[:to] &&  params[:from] == params[:to]
      errors.push("From and To Currencies cannot be Same")
    end
    
    if errors.present?
      error = OpenStruct.new(message: errors.join(', '))
      error_json = {
        status: 422,
        error: :unprocessable_entity,
        exception: {
          message: error.message
        }
      }
      render json: error_json, status: 422 and return 
    end    
  end  
end
