class Homepagess < ApplicationRecord
    # validates :description, length: { in: 150..215 }
    validates :brand_name, presence: true, length: { maximum: 78 }
    validates :description, presence: true, length: { maximum: 27 }
    has_many_attached :covers
end
