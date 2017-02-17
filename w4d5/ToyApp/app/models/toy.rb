class Toy < ActiveRecord::Base
  validates :name, uniqueness:true, presence: true
  validates :name, uniqueness: { scope: :toyable_id}

  belongs_to :toyable, polymorphic: true
end
