class SimplifySchema < ActiveRecord::Migration
  def self.up
    remove_column :people, :alternative_names
    remove_column :people, :description
    remove_column :people, :page_title
    remove_column :people, :page_id
    remove_column :people, :date_of_birth
    remove_column :people, :place_of_birth
    remove_column :people, :place_of_death
    add_column :people, :page_url, :string, :null => false
  end

  def self.down
    remove_column :people, :page_url
    add_column :people, :alternative_names,  :string
    add_column :people, :description,        :string
    add_column :people, :page_title,         :string,   :null => false
    add_column :people, :page_id,            :string,   :null => false
    add_column :people, :date_of_birth,      :datetime
    add_column :people, :place_of_birth,     :string
    add_column :people, :place_of_death,     :string
  end
end
