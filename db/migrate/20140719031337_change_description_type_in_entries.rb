class ChangeDescriptionTypeInEntries < ActiveRecord::Migration
  def up
    change_column :entries, :description, :text
  end
  
  def down
    change_column :entries, :description, :string
  end
end
