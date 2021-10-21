class Api::V1::CurrencyRatesController < Api::V1::BaseController

  def index
    @currency_rates = current_project.currency_rates
  end
end
