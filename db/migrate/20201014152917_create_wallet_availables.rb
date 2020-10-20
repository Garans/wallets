class CreateWalletAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :wallet_availables do |t|
      t.string      :currency_id
      t.date        :expire_date
      t.date        :activated_at
      t.string      :number_encrypted
      t.boolean     :status

      t.timestamps
    end

    add_index :wallet_availables, :currency_id
  end
end
