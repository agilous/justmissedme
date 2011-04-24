class Person < ActiveRecord::Base
  validates :name, :page_url, :date_of_death, :presence => true
end
