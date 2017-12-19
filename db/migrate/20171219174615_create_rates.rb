class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :exchange, null: false
      t.string :base_currency, null: false
      t.string :quote_currency, null: false
      t.decimal :high, precision: 15, scale: 8, null: false
      t.decimal :low, precision: 15, scale: 8, null: false
      t.decimal :bid, precision: 15, scale: 8, null: false
      t.decimal :ask, precision: 15, scale: 8, null: false
      t.decimal :last, precision: 15, scale: 8, null: false

      t.timestamps
    end
  end
end
