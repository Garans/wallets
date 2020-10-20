class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.string            :currency_id
      t.string            :type
      t.string            :description
      t.float             :funds
      t.date              :expire_date
      t.string            :number_encrypted

      t.timestamps
    end
  end
end
