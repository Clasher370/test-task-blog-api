class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.float :post_rating
      t.integer :rating_count
      t.references :post, index: false

      t.timestamps
    end
  end
end
