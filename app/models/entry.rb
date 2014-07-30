class Entry < ActiveRecord::Base
  has_many :relationships, foreign_key: "parent_id", dependent: :destroy
  has_many :children, through: :relationships
  has_one :reverse_relationship, foreign_key: "child_id", 
          class_name: "Relationship", dependent: :destroy
  has_one :parent, through: :reverse_relationship
  validates :name, presence: true
  
  def has_parent?
    parent.present?
  end
  
  def has_children?
    children.present?
  end
  
  def make_parent_of!(other_entry)
    relationships.create!(child_id: other_entry.id)
  end
  
  def orphan!(other_entry)
    relationships.find_by(child_id: other_entry.id).destroy
  end
  
  def make_child_of!(other_entry)
    other_entry.make_parent_of!(self)
  end
  
  def destroy_children
    # Recursively destroys all child entries
    # Returns ids of all child entries destroyed
    roll_call = []
    if has_children?
      children.each do |child|
        roll_call << child.id
        roll_call += child.destroy_children
        child.destroy
      end
    end
    roll_call
  end
end
