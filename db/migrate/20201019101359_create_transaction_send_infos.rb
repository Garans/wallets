# frozen_string_literal: true

class CreateTransactionSendInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_send_infos do |t|
      t.references :transaction
      t.integer           :sender_id
      t.string            :sender_type
      t.integer           :recipient_id
      t.string            :recipient_type
      t.timestamps
    end
  end
end
