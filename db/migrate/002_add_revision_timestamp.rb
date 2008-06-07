class AddRevisionTimestamp < ActiveRecord::Migration
  def self.up
    add_column :people, :revision_timestamp, :datetime
  end

  def self.down
    remove_column :people, :revision_timestamp
  end
end
