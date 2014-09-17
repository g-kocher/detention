class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :date_published
      t.references :company, index: true

      t.timestamps
    end
    add_index :products, :name
    add_index :products, :date_published
  end
end
