class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.float :rate
      t.references :post

      t.timestamps
    end
  end
end
