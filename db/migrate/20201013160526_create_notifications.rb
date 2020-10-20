class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :transaction
      t.string     :message
      t.integer    :status
      t.timestamps
    end
  end
end
