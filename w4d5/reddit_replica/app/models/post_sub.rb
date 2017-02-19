class PostSub < ActiveRecord::Base
  validates :sub_id, :post_id, presence: true

  belongs_to :post
  belongs_to :sub 
end
