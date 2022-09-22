class About < ApplicationRecord
    has_many_attached :images
    has_one_attached :cover
end
