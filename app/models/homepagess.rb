class Homepagess < ApplicationRecord
    validates :description, length: { in: 150..215 }
    has_many_attached :covers
end
