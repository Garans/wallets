class CreateAtms < ActiveRecord::Migration[5.2]
  def change
    create_table :atms do |t|
      t.string      :currency_id
      t.string      :address
      t.string      :number_encrypted
      t.timestamps
    end
  end
end
