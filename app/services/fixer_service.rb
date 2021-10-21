
class FixerService
  BASE_URL = "http://data.fixer.io/api/latest?access_key=#{ENV['FIXER_API_KEY']}"

  #letest endpoint is always returning the base currecny in EURO due to free plain limt 
  def self.latest
    response = HTTParty.get(BASE_URL)
    return nil unless response['success']
    #getting the USD rate Only for now
    { base_currency: response["base"], rates: response["rates"].select{ |rate| rate["USD"]}}
  end
end
