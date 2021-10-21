class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.references :project
      t.string :token, unique: true
      t.timestamps
    end
  end
end
