desc "This task runs the FDA client to refresh the site data"
task refresh_data: :environment do
  puts 'Updating data...'
  import = Import.new
  time = Time.now
  import.refresh
  puts "done in: #{Time.now - time} seconds!"
end