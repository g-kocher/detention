class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :date
      t.references :company, index: true

      t.timestamps
    end
    add_index :products, :date
  end
end
