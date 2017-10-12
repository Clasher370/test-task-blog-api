class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :post, index: false

      t.timestamps
    end
  end
end
