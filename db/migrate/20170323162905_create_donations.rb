class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.belongs_to :pin, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
