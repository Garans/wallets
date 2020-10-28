class AddedOperationTypeToTransactionInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_send_infos, :operation, :integer, default: 0
    remove_column :wallets, :funds
  end
end
