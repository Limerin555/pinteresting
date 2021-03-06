class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.string :title
      t.text :description
      t.integer :money, :default => 0
      t.json :photo
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
