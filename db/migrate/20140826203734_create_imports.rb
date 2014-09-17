class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer  :items_created

      t.timestamps
    end
  end
end
