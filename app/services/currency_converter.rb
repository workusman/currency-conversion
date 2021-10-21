
class CurrencyConverter
  attr_accessor :from, :to, :amount, :project

  def initialize project,params
    @from = params[:from]
    @to = params[:to]
    @amount = params[:amount]
    @project = project
  end


  def convert
    raise "Rate Not Found" unless (from_currency_rate.present? || to_currency_rate.present?)
    converted_amount = from_currency_rate.rates[to] * amount.to_f
    {from: from, to: to, amount: amount , converted_amount: converted_amount}
  end

  def from_currency_rate
    currency_rates.find_by(base_currency: from)
  end

  def to_currency_rate
    currency_rates.find_by(base_currency: to)
  end
  
  def currency_rates
    @rates ||= project.currency_rates
  end

end
