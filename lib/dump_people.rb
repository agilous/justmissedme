f = File.new('/Users/bbarnett/Downloads/people.rb', 'w')
Person.all.each do |p|
  f.write("Person.create(name: \"#{p.name.gsub('"', '\"')}\", date_of_death: \"#{p.date_of_death}\", revision_timestamp: \"#{p.revision_timestamp}\", page_url: \"#{p.page_url}\")\n")
end
f.close
