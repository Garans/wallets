class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.string :symbol_icon, null: false
      t.boolean :is_base, default: false
      t.timestamps
    end

    add_index :currencies, :is_base
  end
end
