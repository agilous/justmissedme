class CreatePeople < ActiveRecord::Migration
  def up
    create_table "people", :force => true do |t|
      t.string   "name",               :default => "", :null => false
      t.datetime "date_of_death",                      :null => false
      t.datetime "revision_timestamp"
      t.string   "page_url",           :default => "", :null => false
    end
  end

  def down
    drop_table "people"
  end
end
