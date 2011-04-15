class PeopleController < ApplicationController

  def list
    @date = Date.new(params[:birthdate])
    @people = Person.find(:all, :conditions => [ "date_of_death < ?", @date ], :limit => 5, :order => "date_of_death DESC")
  end

  def show
    @person = Person.find(params[:id])
  end

end
