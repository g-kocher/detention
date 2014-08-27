class CreatePesticides < ActiveRecord::Migration
  def change
    create_table :pesticides do |t|
      t.string :name

      t.timestamps
    end
    add_index :pesticides, :name
  end
end
