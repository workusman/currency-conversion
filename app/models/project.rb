class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :api_keys, dependent: :destroy
  has_many :currency_rates, dependent: :destroy

  after_create :generate_api_key
  after_create :create_currency_rates
  
  private

  def generate_api_key
    self.api_keys.create!
  end

  def create_currency_rates
    euro_rates = FixerService.latest
    self.currency_rates.create!(euro_rates)
    #as API is returning only EURO rates due to free plan let's create a USD rate by some own calculation
    usd_rates = { base_currency: 'USD', rates: {"#{euro_rates[:base_currency]}": (1 / euro_rates[:rates]["USD"]).round(7)}}
    self.currency_rates.create!(usd_rates)
  end 
end
