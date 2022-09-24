class Comment < ApplicationRecord
  belongs_to :product
  # belongs_to :parent, class_name: "Comment", optional: true
  
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: 'parent_id', dependent: :destroy
end
