class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rate
      t.references :post

      t.timestamps
    end
  end
end
