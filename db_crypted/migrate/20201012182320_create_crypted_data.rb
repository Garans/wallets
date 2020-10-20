class CreateCryptedData < ActiveRecord::Migration[5.2]
  def change
    create_table :crypted_data do |t|
      t.integer       :owner_id
      t.string        :owner_type
      t.string        :value_encrypted
      t.boolean       :is_active
      t.timestamps
    end
  end
end
