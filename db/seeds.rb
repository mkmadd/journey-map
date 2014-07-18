# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative '../app/hacks/dir_reader' 

root_contents = dir_hash('.') #Dir.entries('.')
Entry.delete_all

def enter_entry(entry_hash)
  Entry.create!(name: entry_hash[:name])
  unless entry_hash[:contains].blank?
    entry_hash[:contains].each do |entry|
      enter_entry(entry)
    end
  end
end

enter_entry(root_contents)
