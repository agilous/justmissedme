class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :people do |table|
      table.column :name, :string, :null => false
      table.column :alternative_names, :string
      table.column :description, :string
      table.column :page_title, :string, :null => false
      table.column :page_id, :string, :null => false
      table.column :date_of_birth, :datetime
      table.column :place_of_birth, :string
      table.column :date_of_death, :datetime, :null => false
      table.column :place_of_death, :string
    end
  end

  def self.down
    drop_table :people
  end
end
