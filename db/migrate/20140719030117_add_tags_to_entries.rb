class AddTagsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :tags, :text, array: true, default: []
  end
end
