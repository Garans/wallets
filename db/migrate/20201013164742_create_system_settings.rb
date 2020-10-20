class CreateSystemSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :system_settings do |t|
      t.string      :country
      t.string      :country_short_code
      t.integer     :check_iban_number
      t.string      :name
      t.integer     :mfo
      t.timestamps
    end
  end
end
