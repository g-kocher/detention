class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :pesticide_id
      t.integer :product_id

      t.timestamps
    end
    add_index :problems, :pesticide_id
    add_index :problems, :product_id
  end
end
