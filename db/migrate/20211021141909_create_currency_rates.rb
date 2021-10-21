class CreateCurrencyRates < ActiveRecord::Migration[6.1]
  def change
    create_table :currency_rates do |t|
      t.references :project
      t.string :base_currency
      t.json :rates
      t.timestamps
    end
  end
end
