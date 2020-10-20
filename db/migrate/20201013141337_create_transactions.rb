class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.belongs_to  :commission_rule
      t.string      :currency_id
      t.integer     :parent_id
      t.string      :operation_type
      t.string      :description
      t.integer     :status
      t.float       :amount
      t.float       :commission_amount
      t.float       :full_amount
      t.json        :currency_converters_info
      t.json        :commission_info
      t.string      :system_message
      t.timestamps
    end
  end
end
