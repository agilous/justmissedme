#!/usr/bin/env ruby

require 'config/environment.rb'
require 'rubygems'
require 'hpricot'
require 'open-uri'

found_total = 0
updated_total = 0

found_deaths = false
start_parsing = false

begin_deaths     = Regexp.new('<span class="mw-headline" id="Deaths">Deaths</span>', Regexp::IGNORECASE)
list_item_found  = Regexp.new('<li>')
found_list       = Regexp.new('<ul>', Regexp::IGNORECASE)
stop_parsing     = Regexp.new('<span class="mw-headline" id="Holidays_and_observances">', Regexp::IGNORECASE)
missing_date_url = Regexp.new('<li>([0-9]{1,4}) -', Regexp::IGNORECASE)

months = [ '', 'January', 'February', 'March', 'April', 'May', 'June',
           'July', 'August', 'September', 'October', 'November', 'December' ]

days_in_month = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

for month in 1..12
  for day in 1..days_in_month[month]
    date_url = "http://en.wikipedia.org/wiki/#{months[month]}_#{day}"
    puts "Pasring date URL: #{date_url}"
    open(date_url) do |doc|

      # Skip to the next day if a success code is not received.
# TODO: Fix status checking.
#      puts "Status: #{doc.status.inspect[0].to_s}"
#      next unless doc.status.inspect[0] == '200'

      while line = doc.gets

        # Find the paragraph containing the Deaths anchor.
        if !found_deaths && begin_deaths.match(line)
          found_deaths = true
          next
        end

        # See if we need to start parsing deaths.
        if found_deaths && found_list.match(line)
          start_parsing = true
          next
        end

        # Stop when done!
        if start_parsing && stop_parsing.match(line)
          break
        end

        # Otherwise start parsing.
        if start_parsing

          # Skip the line if it isn't a list item.
          next unless list_item_found.match(line)

          # Parse the year depending upon whether or not the list item begins
          # with a date URL.
          pos = 1
          item = Hpricot(line)
          if missing_date_url.match(line)
            pos = 0
            year_string = Regexp.last_match(1)
          else
            next if (item/"a")[0].nil? # Skip the line if no date was found by now.
            year_string = (item/"a")[0].attributes['title']
          end

          # Skip the line if the date is BC.
          next if year_string =~ /bc/i

          # Set the person's attributes
          year = year_string.to_i
          next if (item/"a")[pos].nil?
          name = (item/"a")[pos].attributes['title']
          url = (item/"a")[pos].attributes['href']

          # If the year, name, and URL are not nil process the person.
          if (!year.nil? && !name.nil? && !url.nil?)
            date_of_death = Date.new(year, month, day).strftime("%Y-%m-%d 00:00:00")
            puts "Found #{name}, #{date_of_death}, #{url}"
            found_person = Person.find_by_page_url(url)
            if found_person
              puts "Updating #{name}, #{date_of_death}, #{url}"
              found_person.revision_timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
              found_person.save
              found_total = found_total + 1
            else
              puts "Found #{name}, #{date_of_death}, #{url}"
              person = Person.new
              person.name = name
              person.date_of_death = date_of_death
              person.page_url = url
              person.revision_timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
              person.save
              updated_total = updated_total + 1
            end
          end
        end
      end

      # Reset the parsing flags.
      found_deaths = false
      start_parsing = false
    end
  end
end

puts "New: #{found_total}, Updated: #{updated_total}"