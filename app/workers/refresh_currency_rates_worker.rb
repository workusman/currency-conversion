require 'sidekiq-scheduler'
class RefreshCurrencyRatesWorker

  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform
    euro_rates = FixerService.latest
    usd_rates = { base_currency: 'USD', rates: {"#{euro_rates[:base_currency]}": (1 / euro_rates[:rates]["USD"]).round(7)}}

    CurrencyRate.where(base_currency: euro_rates[:base_currency]).update_all(rates: euro_rates[:rates])
    CurrencyRate.where(base_currency: usd_rates[:base_currency]).update_all(rates: usd_rates[:rates])
  end
end