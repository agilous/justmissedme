class Person < ActiveRecord::Base
  validates :name, :presence => true
  validates :page_url, :presence => true
  validates :date_of_death, :presence => true
end
