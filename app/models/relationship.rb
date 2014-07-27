class Relationship < ActiveRecord::Base
  belongs_to :parent, class_name: "Entry"
  belongs_to :child, class_name: "Entry"
  validates :parent_id, presence: true
  validates :child_id, presence: true
end
