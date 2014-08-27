class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.datetime :last_scrape
      t.datetime :last_update

      t.timestamps
    end
  end
end
