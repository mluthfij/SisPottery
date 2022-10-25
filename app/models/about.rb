class About < ApplicationRecord
    # has_many_attached :images
    has_one_attached :image
    validates :sub_title, presence: true
    validates :title, presence: true
    validates :description, presence: true
end
