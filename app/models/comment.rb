class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :product
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: 'parent_id', dependent: :destroy
  validates :content, presence: true
end
