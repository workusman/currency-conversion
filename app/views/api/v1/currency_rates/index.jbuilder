json.rates do
  json.partial! "currency_rate", collection: @currency_rates, as: :currency_rate
end