class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :api_keys, dependent: :destroy
  has_many :currency_rates, dependent: :destroy

  after_create :generate_api_key
  after_create :create_currency_rate
  
  private

  def generate_api_key
    self.api_keys.create!
  end

  def create_currency_rate
    rates = FixerService.latest
    self.currency_rates.create!(rates)
  end 
end
