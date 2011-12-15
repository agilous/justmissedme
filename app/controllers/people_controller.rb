class PeopleController < ApplicationController
  def find
  end

  def list
    date = params[:century] + params[:year] + "-" + params[:month] + "-" + params[:day]
    @people = Person.find(:all, :conditions => [ "date_of_death < ?", date ], :limit => 5, :order => "date_of_death DESC")
    @date = params[:month] + "/" + params[:day] + "/" + params[:century] + params[:year]
  end
end