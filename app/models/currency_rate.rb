class CurrencyRate < ApplicationRecord

  SUPPORTED_CURRENCIES = ["USD", "EUR"]
  # refrences it with project so every project has own rates and can have multiple as well
  belongs_to :project
  validates :base_currency, presence: true
end
