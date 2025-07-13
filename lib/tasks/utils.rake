desc "Port data from an SJAA database"
task patch: [:environment] do
  require_relative('../../db/sjaa_port')
  include SjaaPort

  patch(ENV['PATCH_FILE'], ENV['COMMIT'])
end

desc "Compare CSV1 and CSV2 first two columns - used for reconciling membership lists"
task csv_compare: [:environment] do
  csv1 = ENV['CSV1']
  csv2= ENV['CSV2']

  csvh = {csv1 => [], csv2 => []}

  csvh.each do |file, arr|
    CSV.foreach(file, headers: true) do |row|
      key = "#{row[0].strip} #{row[1].strip}"
      arr << key
    end
  end

  results = csvh.deep_dup

  # Look for CSV1 items in CSV2
  #  When found, delete from both
  #  When not found, delete from CSV1
  #  Remainder is what's missing from the other
  csvh[csv1].each do |person|
    results[csv2].delete(person)
    results[csv1].delete(person)
  end

  puts "People in #{csv1} but not #{csv2}"
  puts results[csv1].inspect

  puts "\n------\n"

  puts "People in #{csv2} but not #{csv1}"
  puts results[csv2].inspect
end


desc "Add some fake people to the database"
task generate_data: [:environment] do
  require_relative('../../db/faker_seed')
  include FakerSeed
  generate_people(size: 100)
end