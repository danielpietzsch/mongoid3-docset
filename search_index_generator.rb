require 'sqlite3'

db = SQLite3::Database.new( "./Mongoid 3.docset/Contents/Resources/docSet.dsidx" )

Dir.foreach('./Mongoid 3.docset/Contents/Resources/Documents/mongoid.org/en') do |directory|
  next if directory == '.' || directory == '..' || directory == '.DS_Store'
  query = "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{directory.capitalize}', 'Guide', 'mongoid.org/en/#{directory}/index.html');"
  puts query
  db.execute query

  Dir.foreach("./Mongoid 3.docset/Contents/Resources/Documents/mongoid.org/en/#{directory}/docs") do |section_file|
    next if section_file == '.' || section_file == '..' || section_file == '.DS_Store'
    query = "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{directory.capitalize} - #{File.basename(section_file, '.html').gsub('_', ' ').capitalize}', 'Section', 'mongoid.org/en/#{directory}/docs/#{section_file}');"
    puts query
    db.execute query
  end
end