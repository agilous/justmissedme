class Person < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :page_url
  validates_presence_of :date_of_death
end