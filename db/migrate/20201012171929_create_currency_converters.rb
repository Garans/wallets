class CreateCurrencyConverters < ActiveRecord::Migration[5.2]
  def change
    create_table :currency_converters do |t|
      t.string      :first_currency_id
      t.string      :second_currency_id
      t.float       :course
      t.timestamps
    end

    # add_index :currency_converters, [:first_currency_id, :second_currency_id]
  end
end
