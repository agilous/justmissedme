Factory.define :person do |p|
  p.name Faker::Name.name
  p.page_url "http://en.wikipedia.org/wiki/#{p.name.gsub(" ", "_")}"
  p.date_of_death Date.yesterday
end