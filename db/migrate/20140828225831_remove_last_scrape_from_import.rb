class RemoveLastScrapeFromImport < ActiveRecord::Migration
  def change
    remove_column :imports, :last_scrape, :datetime
  end
end
