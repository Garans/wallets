class CreateCommissionRules < ActiveRecord::Migration[5.2]
  def change
    create_table :commission_rules do |t|
      t.integer :commission_type
      t.float   :rate
      t.float   :from_price
      t.float   :to_price

      t.timestamps
    end
  end
end
